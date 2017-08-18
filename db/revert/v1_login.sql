-- Revert jdb:v1_login from pg

BEGIN;

drop function v1.login(text, text);
drop type if exists jdb.jwt_token;

COMMIT;
