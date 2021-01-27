CREATE DATABASE experiment;
create table foo (bar integer NOT NULL);

CREATE SERVER cockroachdb FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'node1', dbname 'foo', port '26257');

create user mapping for postgres server cockroachdb OPTIONS (user 'root', password '');

-- It'd be neat if this worked, but it uses a collation that postgres 12.5 doesn't recognise
-- IMPORT FOREIGN SCHEMA public LIMIT TO (users) FROM SERVER cockroachdb INTO public;

CREATE FOREIGN TABLE users (
  id bigint OPTIONS (column_name 'id') NOT NULL,
  uuid uuid OPTIONS (column_name 'uuid'),
  email character varying OPTIONS (column_name 'email'),
  name character varying OPTIONS (column_name 'name')
) SERVER cockroachdb
OPTIONS (schema_name 'public', table_name 'users');
