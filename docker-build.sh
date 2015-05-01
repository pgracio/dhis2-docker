#! /bin/bash
current_dir=`pwd`
releases_dir="releases/2.18/"

# copy releases to diferent Dockerfiles usage
ubuntu_releases_dir="ubuntu/web/releases/2.18/" 

if [ ! -d "$releases_dir" ]; then
	mkdir -p $releases_dir
fi

if [ ! -d "$ubuntu_releases_dir" ]; then
	mkdir -p $ubuntu_releases_dir
fi

wget -P "$current_dir/$releases_dir" https://www.dhis2.org/download/releases/2.18/dhis.war

# TODO: read Build Revision after download war and use that to tag image, important to reproduce reported bugs.


# https://docs.docker.com/reference/builder/#copy
# The <src> path must be inside the context of the build; 
# you cannot COPY ../something /something, because the first step of a docker build is to send 
# the context directory (and subdirectories) to the docker daemon.
cp -a "$current_dir/$releases_dir." "$ubuntu_releases_dir"

# build new image using new dhis.war [without tag]
docker build ubuntu/web/

#  --filter "dangling=true"
image_id=`docker images --filter "dangling=true" -q`

docker tag -f $image_id pgracio/dhis2-web:latest
docker tag -f $image_id pgracio/dhis2-web:2.18-xxxx
