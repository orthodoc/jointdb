-- Revert jdb:permission from pg

BEGIN;

revoke execute on function v1.registration(text,text,text) from visitor;
revoke execute on function v1.login(text,text) from visitor, doctor;
revoke execute on function jdb.user_role(text,text) from visitor;
revoke select on table jdb.user from visitor, doctor;
revoke usage on schema jdb, v1 from visitor, doctor;
revoke visitor, doctor from authenticator;

drop role authenticator;
drop role doctor;
drop role visitor;

COMMIT;
