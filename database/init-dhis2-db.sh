#!/usr/bin/env bash
gosu postgres psql -U $POSTGRES_USER -d "$POSTGRES_DB" < /tmp/data/dhis2-db.sql