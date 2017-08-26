-- Verify jdb:user on pg

BEGIN;

select exists(
    select extname
        from pg_extension
        where extname = 'uuid-ossp'
);
select id, email, password, role, created_at, updated_at
    from jdb.user
    where false;
select exists(
    select tgenabled
        from pg_trigger
        where tgname = 'user_updated_at' and tgenabled != 'D'
);
select has_function_privilege('jdb.check_role_exists()', 'execute');
select exists(
    select tgenabled
        from pg_trigger
        where tgname = 'ensure_role_exists' and tgenabled != 'D'
);
select exists(
    select extname
        from pg_extension
        where extname = 'pgcrypto'
);
select has_function_privilege('jdb.encrypt_password()', 'execute');
select exists(
    select tgenabled
        from pg_trigger
        where tgname = 'encrypt_password' and tgenabled != 'D'
);
select has_function_privilege('jdb.current_user()','execute');

ROLLBACK;
