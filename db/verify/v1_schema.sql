-- Verify jdb:v1_schema on pg

BEGIN;

select pg_catalog.has_schema_privilege('v1', 'usage');

ROLLBACK;
