-- Deploy jdb:permission to pg
-- requires: jdbschema

BEGIN;

-- Roles for JDB
create role visitor;
create role doctor;
create role authenticator noinherit;

comment on role visitor is 'User who has restricted access';
comment on role doctor is 'Authenticated user who has access to all jdb services';
comment on role authenticator is 'If auth succeeds, takes on the role of one of the user';

-- Permissions
-- Authenticator can take the role of a visitor
grant visitor, doctor to authenticator;

-- Visitor and doctor roles can operate upon the schemas: jdb and v1
grant usage on schema jdb, v1 to visitor, doctor;

-- visitor and doctor can select rows from the user table
grant select on table jdb.user to visitor, doctor;

-- visitor can execute login function
grant execute on function jdb.user_role(text, text) to visitor;
grant execute on function v1.login(text,text) to visitor, doctor;
grant execute on function v1.registration(text, text, text) to visitor;

COMMIT;
