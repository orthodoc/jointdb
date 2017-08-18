-- Deploy jdb:pgjwt to pg
-- requires: jdbschema

BEGIN;

-- pgjwt extension as in https://github.com/michelp/pgjwt/blob/master/pgjwt--0.0.1.sql. Not included under extensions available for AWS RDS, so have to recreate with sql

create or replace function
  jdb.url_encode(data bytea)
  returns text as
  $$
    select translate(encode(data, 'base64'), E'+/=\n', '-_');
  $$ language sql;
comment on function jdb.url_encode(bytea) is 'Function to create Base64Url encoded json';

create or replace function
  jdb.url_decode(data text)
  returns bytea as
  $$
    with t as (select translate(data, '-_', '+/')),
    rem as (select length((select * from t)) % 4) -- compte padding size
    select decode (
      (select * from t) ||
      case when (select * from rem) > 0
        then repeat('=', (4 - (select * from rem)))
        else '' end,
      'base64');
  $$ language sql;
comment on function jdb.url_decode(text) is 'Function to decode Base64Url encoded json';

create or replace function
  jdb.algorithm_sign(signables text, secret text, algorithm text)
  returns text as
  $$
    with alg as (
      select case
        when algorithm = 'HS256' then 'sha256'
        when algorithm = 'HS384' then 'sha384'
        when algorithm = 'HS512' then 'sha512'
        else '' end) -- hmac throws an error
    select jdb.url_encode(hmac(signables, secret, (select * from alg)));
  $$ language sql;
comment on function jdb.algorithm_sign(text, text, text) is 'Function to sign using a specified algorithm';

create or replace function
  jdb.sign(payload json, secret text, algorithm text default 'HS256')
  returns text as
  $$
    with
      header as (
        select jdb.url_encode(convert_to('{"alg":"' || algorithm || '", "typ":"JWT"}', 'utf8'))
        ),
      payload as (
        select jdb.url_encode(convert_to(payload::text, 'utf8'))
        ),
      signables as (
        select (select * from header) || '.' || (select * from payload)
        )
    select
      (select * from signables)
      || '.' ||
      jdb.algorithm_sign((select * from signables), secret, algorithm);
  $$ language sql;
comment on function jdb.sign(json, text, text) is 'Function to create the JWT using the secret';

create or replace function
  jdb.verify(token text, secret text, algorithm text default 'HS256')
  returns table(header json, payload json, valid boolean) as
  $$
    select
      convert_from(jdb.url_decode(r[1]), 'utf8')::json as header,
      convert_from(jdb.url_decode(r[2]), 'utf8')::json as payload,
      r[3] = jdb.algorithm_sign(r[1] || '.' || r[2], secret, algorithm) as valid
    from regexp_split_to_array(token, '\.') r;
  $$ language sql;
comment on function jdb.verify(text, text, text) is 'Function to verify the token using the secret';

alter database jdb_test set "jdb.jwt_secret" to '!!jdbapiisthebestesthealthcareapi!!';

COMMIT;
