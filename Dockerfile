FROM tomcat:7-jre8

RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY conf/hibernate.properties /opt/dhis2/config/hibernate.properties
COPY conf/dhis.conf /opt/dhis2/config/dhis.conf
COPY releases/dhis2.war /usr/local/tomcat/webapps/ROOT.war

COPY wait-for-it.sh wait-for-it.sh
RUN sed -e -i "s/port=\"8080\" protocol=\"HTTP\/1.1\"/port=\"8080\" protocol=\"HTTP\/1.1\"\\n relaxedQueryChars=\"\[,\]\"/" //usr/local/tomcat/conf/server.xml
RUN echo "export JAVA_OPTS=$JAVA_OPTS\nexport DHIS2_HOME='/opt/dhis2/config'" >> /usr/local/tomcat/bin/setenv.sh
