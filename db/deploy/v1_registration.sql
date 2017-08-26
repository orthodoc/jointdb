-- Deploy jdb:v1_registration to pg
-- requires: v1_schema
-- requires: pgjwt

BEGIN;

-- Function
create or replace function
    v1.registration(
            email text default null,
            password text default null,
            phone_number text default null,
            role text default 'visitor'
        )
        returns jdb.jwt_token as
    $$
    declare
        _user jdb.user;
        result jdb.jwt_token;
    begin
        if email is not null and phone_number is not null then
            insert into jdb.user (email, password, phone_number, role)
                values (email, password, phone_number, role)
                returning * into _user;
        end if;
        if email is null and phone_number is not null then
            insert into jdb.user(phone_number, role)
                values (phone_number, role)
                returning * into _user;
        end if;
        if email is not null and phone_number is null then
            insert into jdb.user(email, password, role)
                values (email, password, role)
                returning * into _user;
        end if;
        if _user is null then
            raise invalid_password using message = 'invalid email or password or phone number';
        end if;
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
    $$ language plpgsql security definer;
comment on function v1.registration(text, text, text,  text) is 'Function to register a doctor as a user';

COMMIT;
