-- Verify jdb:v1_login on pg

BEGIN;

select exists (
    select 1 from pg_type
        where typname = 'jwt_token'
);
select has_function_privilege('v1.login(text, text)', 'execute');

ROLLBACK;
