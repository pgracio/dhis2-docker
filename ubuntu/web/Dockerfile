#
# DHIS2 - Web Image
# https://www.dhis2.org/doc/snapshot/en/implementer/html/ch08s02.html
#
FROM ubuntu
MAINTAINER paulo.gracio@gmail.com

# Create a dedicated user for running DHIS - it is not recommended to run as the root user. 
# Create a new user called dhis2
RUN useradd -d /home/dhis -m dhis -s /bin/bash

# make the user able to perform operations temporarily as root user
RUN usermod -G sudo dhis

# set the password for your account
# RUN echo -e "eRjht6wR\\neRjht6wR" | passwd dhis
RUN echo dhis:eRjht6wR | /usr/sbin/chpasswd

# 8.2.6. Database configuration
COPY conf/hibernate.properties /opt/dhis2/config/hibernate.properties

# NOT WORKING YET
#RUN echo "hibernate.connection.url = jdbc:postgresql://"$DHIS2_DB_PORT_5432_TCP_ADDR":"$DHIS2_DB_PORT_5432_TCP_PORT"/dhis" >> /opt/dhis2/config/hibernate.properties

# 8.2.7. Install Java
RUN apt-get update && apt-get install -y openjdk-7-jdk tomcat7-user curl postgresql-client

# 8.2.8. Install Tomcat and DHIS2
RUN cd /opt/dhis2/ && tomcat7-instance-create tomcat7 && chmod +x /opt/dhis2/tomcat7/bin/*.sh

RUN echo "export JAVA_HOME='/usr/lib/jvm/java-7-openjdk-amd64'\nexport JAVA_OPTS='-Xmx7500m -Xms4000m -XX:MaxPermSize=500m -XX:PermSize=300m'\nexport DHIS2_HOME='/opt/dhis2/config'" >> /opt/dhis2/tomcat7/bin/setenv.sh

# download the DHIS 2 WAR file and place it into the webapps directory of Tomcat
#ADD https://www.dhis2.org/download/releases/2.18/dhis.war /opt/dhis2/tomcat7/webapps/ROOT.war
COPY releases/2.18/dhis.war /opt/dhis2/tomcat7/webapps/ROOT.war

# Define service
COPY conf/tomcat7 /etc/init.d/tomcat7
RUN chmod 755 /etc/init.d/tomcat7
#RUN update-rc.d tomcat7 defaults

# Expose the TOMCAT default port
EXPOSE 8080

CMD service tomcat7 start && tail -f /opt/dhis2/tomcat7/logs/catalina.out