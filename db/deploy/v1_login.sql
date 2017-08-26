-- Deploy jdb:v1_login to pg
-- requires: v1_schema
-- requires: pgjwt

BEGIN;

-- Function
create or replace function
    v1.login(email text default null, password text default null, phone_number text default null) returns jdb.jwt_token as
    $$
    declare
        _user jdb.user;
        result jdb.jwt_token;
    begin
        -- check email and password
        if email is not null and phone_number is null then
            select * from jdb.user
                where login.email = jdb.user.email
                and crypt(login.password, jdb.user.password) = jdb.user.password
                into _user;
        end if;
        -- check phone number
        if email is null and phone_number is not null then
            select * from jdb.user
                where login.phone_number = jdb.user.phone_number
                into _user;
        end if;
        if _user is null then
            raise invalid_password using message = 'invalid email or password or phone number';
        end if;
        -- sign and release token
        select jdb.sign(
                row_to_json(r), current_setting('jdb.jwt_secret')
            ) as token
            from (
                select (_user).id as user_id, (_user).role as role,
                    extract(epoch from now())::integer + 60*60 as exp
            ) r
            into result;
        return result;
    end;
    $$ language plpgsql;
    comment on function v1.login(text,text,text) is 'Function to login as a user';

COMMIT;
