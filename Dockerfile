# Build stage
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Runtime stage
FROM tomcat:10.1-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/Baitap2.war /usr/local/tomcat/webapps/ROOT.war

# Render port configuration
ENV PORT=10000
EXPOSE $PORT

# Sửa port và chạy Tomcat - CÚ PHÁP ĐÚNG
CMD bash -c "sed -i 's/port=\"8080\"/port=\"$PORT\"/' /usr/local/tomcat/conf/server.xml && catalina.sh run"
