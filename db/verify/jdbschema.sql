-- Verify jdb:jdbschema on pg

BEGIN;

select pg_catalog.has_schema_privilege('jdb', 'usage');

ROLLBACK;
