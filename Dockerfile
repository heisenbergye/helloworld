FROM daocloud.io/library/tomcat:8.5.15-jre8
MAINTAINER poc@boc.cn

#install maven
RUN mkdir -p /var/tmp/maven
ADD apache-maven-3.5.3-bin.tar.gz /var/tmp/maven/

#setting env
ENV M2_HOME /var/tmp/maven/apache-maven-3.5.3

RUN mkdir /var/tmp/webapp/
ADD ./demo /var/tmp/webapp/
ADD pom.xml /var/tmp/webapp/
RUN cd /var/tmp/webapp/ && mvn package
RUN cp /var/tmp/webapp/target/daocloud.war /usr/local/tomcat/webapps/

#internal service port
EXPOSE 8080

#start tomcat
CMD ["catalina.sh","run"]
