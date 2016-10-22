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

#rm -rf dhis2-db.sql.gz

#curl -L -o dhis2-db.sql.gz https://github.com/dhis2/dhis2-demo-db/blob/master/$DATA_SET/$VERSION_TMP/dhis2-db-$DATA_SET.sql.gz?raw=true
docker build -t pgracio/dhis2-db:$DHIS2_VERSION-$DATA_SET .