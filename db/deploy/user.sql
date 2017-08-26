-- Deploy jdb:user to pg
-- requires: jdbschema

BEGIN;

--Extension
create extension if not exists "uuid-ossp";

-- Table
create table if not exists jdb.user (
    id                     uuid not null default uuid_generate_v1mc(),
    email                text,
    password          text,
    phone_number  text,
    role                  name not null default 'visitor' check (length(role) < 512),
    created_at        timestamp default now(),
    updated_at       timestamp default now(),
    constraint       user_pk primary key(id),
    constraint       user_email_uk unique(email) not deferrable initially immediate,
    constraint       check_email_or_phone check (
        phone_number is not null and email is null
        or
        phone_number is null and email ~* '^.+@.+\..+$'
        or
        phone_number is not null and email ~* '^.+@.+\..+$'
    ),
    constraint       check_password check (
        email is null and password is null
        or
        email is not null and password is not null and (length(password) < 512)
    )
);

comment on table jdb.user is 'Holds the user accounts of jdb users';
comment on column jdb.user.id is 'Primary unique identifier of the user table';
comment on column jdb.user.email is 'Unique email identifying the user';
comment on column jdb.user.password is 'Password of the user';
comment on column jdb.user.created_at is 'Time when the user account was created';
comment on column jdb.user.updated_at is 'Time when the user acccount was updated';

-- Trigger
-- Function is locate in utility.sql
create trigger user_updated_at before update
    on jdb.user
    for each row
    execute procedure jdb.set_updated_at();

comment on trigger user_updated_at on jdb.user is 'Trigger to set updated_at column with the time when record is altered';


-- Role in the user table has to be a foreign key to actual db roles. However postgresql does not support constraints against the pg_roles table. So have to manually enforce this
-- See: https://postgrest.com/en/v0.4/auth.html#roles-for-each-web-user
create or replace function
    jdb.check_role_exists() returns trigger as
    $$
    begin
        if not exists
            (select 1 from pg_roles as r where r.rolname = new.role)
        then
            raise foreign_key_violation using
                message = 'Unknown database role: ' || new.role;
            return null;
        end if;
        return new;
    end;
    $$ language plpgsql;

comment on function jdb.check_role_exists() is 'Function that checks if the new role exists as a db role';

create constraint trigger ensure_role_exists
    after insert or update
    on jdb.user
    for each row
    execute procedure jdb.check_role_exists();

comment on trigger ensure_role_exists on jdb.user is 'Triggers the function to check existence of a db role before upserting the table';

-- Extension
create extension if not exists pgcrypto;

-- Encrypt passwords in the user table
create or replace function
    jdb.encrypt_password() returns trigger as
    $$
    begin
        if tg_op = 'INSERT' or new.password <> old.password  then
            new.password = crypt(new.password, gen_salt('bf'));
        end if;
        return new;
    end;
    $$ language plpgsql;

comment on function jdb.encrypt_password() is 'Function to encrypt passwords in the user table';

create trigger encrypt_password 
    before insert or update
    on jdb.user
    for each row
    execute procedure jdb.encrypt_password();

comment on trigger encrypt_password on jdb.user is 'Triggers the encryption of password in the user table';

-- Postgresql has a current_user() function/procedure that returns the username of the logged in user
-- jdb.current_user() has to be called from the jdb schema and returns specifically the user_id of the user identified by the JWT
create function jdb.current_user()
    returns jdb.user as
    $$
    select *
        from jdb.user
        where id = current_setting('request.jwt.claim.user_id')::uuid;
    $$ language sql stable;

comment on function jdb.current_user() is 'Gets the user identified by the JWT';

COMMIT;
