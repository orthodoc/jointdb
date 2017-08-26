-- Verify jdb:v1_login on pg

BEGIN;

select has_function_privilege('v1.login(text, text, text)', 'execute');

ROLLBACK;
