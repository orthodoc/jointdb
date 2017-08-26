-- Revert jdb:v1_registration from pg

BEGIN;

drop function v1.registration(text, text, text, text);

COMMIT;
