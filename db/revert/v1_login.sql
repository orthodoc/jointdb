-- Revert jdb:v1_login from pg

BEGIN;

drop function v1.login(text, text, text);

COMMIT;
