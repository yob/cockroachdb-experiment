Exploring cockroachdb to see how it works.

# start the cluster

    docker-compose up

# the first time the cluster is started, initialse it:

    docker-compose run dev
    cockroach init --insecure --host=node1

# Web dashboard

A web dashboard is available at http://localhost:8080

# To start a SQL REPL:

    docker-compose run dev
    cockroach sql --insecure --host=node1

# Create some test data

    CREATE DATABASE foo;
    SET database='foo';
    CREATE TABLE users (id BIGINT PRIMARY KEY DEFAULT unique_rowid(), uuid uuid DEFAULT gen_random_uuid(), email varchar, name varchar);
    CREATE INDEX ON users (uuid);
    CREATE INDEX ON users (email);
    CREATE INDEX ON users (name);
    INSERT INTO users(email, name) SELECT concat(i::text, '@gmail.com'), concat('User ',i::text) FROM generate_series(0, 1000000) AS t(i);

# Misc Useful SQL

## list all available databases

    SHOW DATABASES;

## show currently connected database

    show database;

## connect to a database

    SET database='foo';

## show tables in current database

    SHOW TABLES;

## show schema of a table

    SHOW CREATE TABLE users;

# Mess with node availability

Try these, and watch the impact on the web dashboard

    docker-compose pause <node1/node2/node3>
    docker-compose unpause <node1/node2/node3>
