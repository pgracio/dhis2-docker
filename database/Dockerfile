FROM postgres:9.5

ADD dhis2-db.sql.gz /tmp/data/dhis2-db.sql.gz
ADD dhis2-postgres.sh /docker-entrypoint-initdb.d/
RUN gunzip /tmp/data/dhis2-db.sql.gz

EXPOSE 5432