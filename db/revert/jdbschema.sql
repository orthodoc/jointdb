-- Revert jdb:jdbschema from pg

BEGIN;

drop schema jdb;

COMMIT;
