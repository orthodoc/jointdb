-- Revert jdb:pgjwt from pg

BEGIN;

drop type if exists jdb.jwt_token;
drop function jdb.verify(text, text, text);
drop function jdb.sign(json, text, text);
drop function jdb.algorithm_sign(text, text, text);
drop function jdb.url_decode(text);
drop function jdb.url_encode(bytea);

COMMIT;
