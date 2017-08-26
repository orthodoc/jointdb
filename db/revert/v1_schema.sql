-- Revert jdb:v1_schema from pg

BEGIN;

drop schema if exists v1;

COMMIT;
