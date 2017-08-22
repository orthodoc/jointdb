-- Verify jdb:v1_register_dr on pg

BEGIN;

select has_function_privilege('v1.registration(text,text,text)', 'execute');

ROLLBACK;
