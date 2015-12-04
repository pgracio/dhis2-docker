#! /bin/bash

set -e;

# On failure: print usage and exit with 1
function print_usage {
  me=`basename "$0"`
  echo "Usage: ./$me -v <dhis2 version>";
  echo "Example: ./$me -v 2.20";
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

#wget -O "$current_dir/$releases_dir/$file_name" "https://www.dhis2.org/download/releases/$DHIS2_VERSION/dhis.war"

cp -a "$current_dir/$releases_dir/$file_name" "$current_dir/$releases_dir/dhis.war"

# build new image using new dhis.war [without tag]
docker build .

#  --filter "dangling=true"
image_id=`docker images --filter "dangling=true" -q`

docker tag -f $image_id pgracio/dhis2-web:latest
docker tag -f $image_id pgracio/dhis2-web:tomcat7-jre8-$DHIS2_VERSION

docker push pgracio/dhis2-web