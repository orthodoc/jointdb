-- Verify jdb:permission on pg

BEGIN;

select exists (
    select 1 from pg_roles where rolname = 'visitor'
);
select exists (
    select 1 from pg_roles where rolname = 'doctor'
);
select exists (
    select 1 from pg_roles where rolname = 'authenticator'
);

select pg_has_role('authenticator','visitor', 'member');
select pg_has_role('authenticator','doctor','member');

select has_schema_privilege('visitor', 'jdb', 'usage');
select has_schema_privilege('visitor','v1','usage');
select has_schema_privilege('authenticator','jdb','usage');
select has_schema_privilege('authenticator','v1','usage');
select has_schema_privilege('doctor','jdb','usage');
select has_schema_privilege('doctor','v1','usage');

select has_table_privilege('doctor','jdb.user','select');
select has_table_privilege('visitor','jdb.user','select');

select has_function_privilege('visitor','v1.login(text,text,text)','execute');
select has_function_privilege('doctor', 'v1.login(text,text,text)','execute');
select has_function_privilege('visitor', 'v1.registration(text,text,text,text)','execute');

ROLLBACK;
