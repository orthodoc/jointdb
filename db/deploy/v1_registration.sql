-- Deploy jdb:v1_registration to pg
-- requires: v1_schema
-- requires: pgjwt

BEGIN;

-- Function
create or replace function
    v1.registration(email text, password text, role text) returns jdb.jwt_token as
    $$
    declare
        _user jdb.user;
        result jdb.jwt_token;
    begin
        insert into jdb.user (email, password, role)
            values (email, password, role)
            returning * into _user;
        if _user is null then
            raise invalid_password using message = 'invalid email or password';
        end if;
        select jdb.sign(
                row_to_json(r), current_setting('jdb.jwt_secret')
            ) as token
            from (
                select (_user).role as role, (_user).email as email,
                 extract(epoch from now())::integer + 60*60 as exp
            ) r
            into result;
        return result;
    end;
    $$ language plpgsql strict security definer;
comment on function v1.registration(text, text, text) is 'Function to register a doctor as a user';

COMMIT;
