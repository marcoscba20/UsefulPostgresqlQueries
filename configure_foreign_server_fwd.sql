/* This query is used to create a couple of tables and configure the postgresql extension (postgres_fwd). We use it to query different tables from other databases in the same query */
create database source;
create database principal;

-- From SOURCE DATABASE create table
create table public.origin
(
    fake_id   integer,
    name      varchar,
    last_name varchar
);
-- Create SAMPLE DATA
insert into public.origin values (1,'Delfi','Adlercreutz');
insert into public.origin values (2,'Feli','Adlercreutz');
insert into public.origin values (3,'Igna','Adlercreutz');

-- Create extension in PRINCIPAL DATABASE and in SOURCE DATABASE
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

-- Create server object PRINCIPAL DATABASE and FOREIGN DATABASE
CREATE SERVER source_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'source');


-- From FOREIGN SERVER create user mapping
CREATE USER MAPPING FOR postgres
SERVER source_server

OPTIONS (user 'postgres', password '123456');


-- In PRINCIPAL SERVER
IMPORT FOREIGN SCHEMA public
FROM SERVER source_server INTO public;

-- Check if it works
select * from origin;
