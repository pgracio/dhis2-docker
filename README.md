dhis2-docker
==============

This document describes the requirement allowing to easily run [dhis2](https://www.dhis2.org/) using [docker](https://www.docker.com/) containers.

Prerequisites
-------------

* [Install Fig](http://www.fig.sh/install.html "Documentation") 


How to have dhis2 running in one command?
--------------

Start a terminal, then run:

```
git clone git://github.com/pgracio/dhis2-docker.git
cd dhis2-docker
fig up
```

Once the container is up, open url http://127.0.0.1:8080 and connect using usernmame `admin` and password `district` as explained in the [dhis2 documentation](https://www.dhis2.org/doc/snapshot/en/user/html/ch02.html#d5e283)


Docker images
--------------
Docker images can be found at [Docker Hub](https://registry.hub.docker.com/repos/pgracio/ "Docker Hub")


Bugs, new requests or contribution
--------------
Please submit bugs, gripes and feature requests at https://github.com/pgracio/dhis2-docker/issues

Any other questions contact Paulo Grácio on Twitter at @pjrgracio, email at paulo.gracio@gmail.com
