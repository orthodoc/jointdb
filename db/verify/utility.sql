-- Verify jdb:utility on pg

BEGIN;

select has_function_privilege('jdb.set_updated_at()', 'execute');
select has_function_privilege('jdb.get_env_var(text)','execute');

ROLLBACK;
