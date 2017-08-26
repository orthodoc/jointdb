-- Revert jdb:utility from pg

BEGIN;

drop function jdb.get_env_var(text);
drop function jdb.set_updated_at();

COMMIT;
