-- Deploy jdb:v1_schema to pg

BEGIN;

create schema if not exists v1;
comment on schema v1 is 'Namespace to hold all the objects accessible by api endpoints version 1';

COMMIT;
