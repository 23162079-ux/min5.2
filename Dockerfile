FROM tomcat:10.1-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY  Baitap2.war /usr/local/tomcat/webapps/ROOT.war

CMD ["bash","-lc","sed -ri 's/port=\"8080\"/port=\"${PORT:-8080}\"/' /usr/local/tomcat/conf/server.xml && catalina.sh run"
