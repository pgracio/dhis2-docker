dhis2-docker
==============

This document describes the requirement allowing to easily run [dhis2](https://www.dhis2.org/) using [docker](https://www.docker.com/) containers.

Prerequisites
-------------

* [Install Docker](http://docs.docker.com/engine/installation/ "Documentation") 


How to have dhis2 running in one command?
--------------

Start a terminal, then run:

```
git clone git://github.com/pgracio/dhis2-docker.git
cd dhis2-docker
docker-compose up -d
```

Once the container is up, open url http://127.0.0.1:8085 and connect using usernmame `admin` and password `district` as explained in the [dhis2 documentation](https://www.dhis2.org/doc/snapshot/en/user/html/ch02.html#d5e283)

When running on Mac OS X or Windows pointing to localhost will fail. It fails because de Docker Host address is not the localhost but instead the address of docker host VM. Run `$ docker-machine ip default` to get Docker Host address. 

Docker images
--------------
Docker images can be found at [Docker Hub](https://registry.hub.docker.com/repos/pgracio/ "Docker Hub")


Using tutum for DHIS2 containers cloud deployment
-------------
Tutum handles the orchestration of your infrastructure and application containers. The simplest DevOps you'll find without compromising on flexibility, they say...

[Tutum is free during Beta](https://dashboard.tutum.co/accounts/register/) and you will get Tutum free forever Developer plan.

Tutum supports several providers:

* [Amazon Web Services](http://aws.amazon.com/ec2/pricing/)
* [Digital Ocean](https://www.digitalocean.com/)
* [Microsoft Azure]()
* [SoftLayer](http://www.softlayer.com/)

For testing purposes I'm using AWS Free Tier. All you have to do is

1. [Create AWS Account](https://portal.aws.amazon.com/gp/aws/developer/registration/index.html)
2. [Create Tutum Account](https://dashboard.tutum.co/accounts/register/)
3. [Link AWS Account with Tutum](https://support.tutum.co/support/solutions/articles/5000224910)
4. [Create a node](https://support.tutum.co/support/solutions/articles/5000523221-your-first-node)
5. [Create and deploy stack](https://support.tutum.co/support/solutions/articles/5000569899-stacks) using the following Stack file

```
database:
  image: 'pgracio/dhis2-db:2.21-sierra-leone'
  environment:
    - PG_DATA=/var/lib/postgresql/data/pgdata
    - POSTGRES_DB=dhis
    - POSTGRES_PASSWORD=dhis
    - POSTGRES_USER=dhis
  volumes:
    - '/opt/dhis2/database/221-sierra-leone:/var/lib/postgresql/data'
web:
  image: 'pgracio/dhis2-web:latest'
  deployment_strategy: high_availability
  environment:
    - 'JAVA_OPTS=-Xmx1024m -Xms4000m'
  links:
    - database
  ports:
    - '8080'
```


Bugs, new requests or contribution
--------------
Please submit bugs, gripes and feature requests at https://github.com/pgracio/dhis2-docker/issues

Any other questions contact Paulo Grácio on Twitter at @pjrgracio, email at paulo.gracio@gmail.com
