-- Verify jdb:pgjwt on pg

BEGIN;

select has_function_privilege('jdb.url_encode(bytea)', 'execute');
select has_function_privilege('jdb.url_decode(text)', 'execute');
select has_function_privilege('jdb.algorithm_sign(text, text, text)', 'execute');
select has_function_privilege('jdb.sign(json, text, text)', 'execute');
select has_function_privilege('jdb.verify(text, text, text)', 'execute');
select exists (
    select 1 from pg_type
        where typname = 'jwt_token'
);

ROLLBACK;
