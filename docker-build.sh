#! /bin/bash

set -x;

# On failure: print usage and exit with 1
function print_usage {
  me=`basename "$0"`
  echo "Usage: ./$me -v <dhis2 version>";
  echo "Example: ./$me -v 2.23";
  exit 1;
}

function validate_parameters {
  if [ -z "$DHIS2_VERSION" ] ; then
    print_usage;
  fi
}

while getopts "v:" OPTION
do
  case $OPTION in
    v)  DHIS2_VERSION=$OPTARG;;
    \?) print_usage;;
  esac
done

validate_parameters

current_dir=`pwd`
releases_dir="releases/$DHIS2_VERSION"

if [ ! -d "$releases_dir" ]; then
    mkdir -p $releases_dir
fi

file_name=`date +dhis2-%Y%m%d.war`
dt=`date '+%Y%m%d-%H%M%S'`

rm -f $current_dir/releases/dhis2.war

wget -O "$current_dir/$releases_dir/$file_name" "https://www.dhis2.org/download/releases/$DHIS2_VERSION/dhis.war"

cp -a "$current_dir/$releases_dir/$file_name" "$current_dir/releases/dhis2.war"

# build new image using new dhis.war 
docker build -t dhis2/dhis2-web:$DHIS2_VERSION-tomcat7-jre8-$dt .

#docker tag -f $image_id pgracio/dhis2-web:latest

#docker push dhis2/dhis2-web
