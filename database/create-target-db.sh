#!/bin/bash
set -e

function debug_message {
  echo "POSTGRES_DB_TARGET not set, target database won't be created.";
}

function create_db {
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE "$POSTGRES_DB_TARGET";
    GRANT ALL PRIVILEGES ON DATABASE "$POSTGRES_DB_TARGET" TO "$POSTGRES_USER";
EOSQL
}

function execute {
  if [ -z ${POSTGRES_DB_TARGET+x} ];
  then
    debug_message;
  else
    create_db;
  fi
}

execute