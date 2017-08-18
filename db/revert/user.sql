-- Revert jdb:user from pg

BEGIN;

drop function jdb.user_role(text, text);
drop trigger if exists encrypt_password on jdb.user;
drop function jdb.encrypt_password();
drop extension if exists pgcrypto;
drop trigger if exists ensure_role_exists on jdb.user;
drop function jdb.check_role_exists();
drop trigger if exists user_updated_at on jdb.user;
drop table jdb.user cascade;
drop extension if exists "uuid-ossp";

COMMIT;
