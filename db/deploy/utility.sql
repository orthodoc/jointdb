-- Deploy jdb:utility to pg
-- requires: jdbschema

BEGIN;

-- Function
create or replace function jdb.set_updated_at() returns trigger as
$$
begin
    new.updated_at := current_timestamp;
    return new;
end;
$$ language plpgsql;

comment on function jdb.set_updated_at() is 'Returns updated_at as the time when the function is triggered. Used to set the updated_at column';

-- Function
create or replace function
    jdb.get_env_var(variable text)
    returns text as
    $$
    declare
        result text;
    begin
        begin
            select current_setting(variable) into result;
        exception
            when undefined_object then
            return null;
        end;
        return result;
    end;
    $$ language plpgsql;
comment on function jdb.get_env_var(text) is 'Function to read env variables';

COMMIT;
