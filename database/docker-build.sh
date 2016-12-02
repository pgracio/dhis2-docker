#! /bin/bash

set -e;

# On failure: print usage and exit with 1
function print_usage {
  me=`basename "$0"`
  echo "Usage: ./$me -v <dhis2 version> -d <data set>";
  echo "Example: ./$me -v 2.20 -d sierra-leone";
  exit 1;
}

function validate_parameters {
  if [ -z "$DHIS2_VERSION" ] || [ -z "$DATA_SET" ]  ; then
    print_usage;
  fi
}

function patch_demo_db {
  gunzip dhis2-db.sql.gz

  # The demo database has the ability to run analytics disabled. This SQL enables the functionality.
  echo "
    INSERT INTO userrolemembers 
    SELECT b.userroleid,a.userid from 
    (SELECT userid from users where username = 'admin' ) a
    CROSS JOIN (SELECT userroleid from userrole where name = 'System administrator (ALL)') b;
  " >> dhis2-db.sql

  gzip dhis2-db.sql
}

function fetch_data {
  rm -rf dhis2-db.sql.gz

  if [ $DATA_SET == "sierra-leone" ]; then
    curl -L -o dhis2-db.sql.gz https://github.com/dhis2/dhis2-demo-db/blob/master/$DATA_SET/$VERSION_TMP/dhis2-db-$DATA_SET.sql.gz?raw=true
  elif [ $DATA_SET == "trainingland" ]; then
    curl -L -o dhis2-db.sql.gz https://github.com/dhis2/dhis2-demo-db/raw/master/trainingland/trainingland.sql.gz?raw=true
  elif [ $DATA_SET == "world-adoption" ]; then
    curl -L -o dhis2-db.sql.gz https://github.com/dhis2/dhis2-demo-db/raw/master/world-adoption/world-adoption.sql.gz?raw=true
  fi
  
  patch_demo_db
}

while getopts "v:d:" OPTION
do
  case $OPTION in
    v)  DHIS2_VERSION=$OPTARG;;
    d)  DATA_SET=$OPTARG;;
    \?) print_usage;;
  esac
done

validate_parameters

VERSION_TMP=${DHIS2_VERSION//[-._]/}

fetch_data

docker build -t pgracio/dhis2-db:$DHIS2_VERSION-$DATA_SET .
