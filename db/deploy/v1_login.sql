-- Deploy jdb:v1_login to pg
-- requires: v1_schema
-- requires: pgjwt

BEGIN;

-- Function
create or replace function
    v1.login(email text, password text) returns jdb.jwt_token as
    $$
    declare
        _role name;
        result jdb.jwt_token;
    begin
        -- check email and password
        select jdb.user_role(email, password) into _role;
        if _role is null then
            raise invalid_password using message = 'invalid user or password';
        end if;
        -- sign and release token
        select jdb.sign(
                row_to_json(r), current_setting('jdb.jwt_secret')
            ) as token
            from (
                select _role as role, login.email as email,
                    extract(epoch from now())::integer + 60*60 as exp
            ) r
            into result;
        return result;
    end;
    $$ language plpgsql;

COMMIT;
