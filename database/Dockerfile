FROM postgres:14-alpine

COPY 01-cofk-users-postgres-schema.sql /docker-entrypoint-initdb.d
COPY 02-cofk-empty.postgres.schema.sql /docker-entrypoint-initdb.d
COPY 03-cofk-initial.postgres.schema.data.sql /docker-entrypoint-initdb.d