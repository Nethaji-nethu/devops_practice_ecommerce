FROM maven:3.9.6-eclipse-temurin-11 as download-deps
WORKDIR /app
#COPY pom.xml .
#COPY .classpath .
#COPY .project .
#COPY src .
COPY pom.xml .
RUN mvn dependency:resolve-plugins

FROM download-deps as build-stage
COPY . .
RUN mvn package -DskipTests


FROM tomcat:9.0.85-jre11-temurin-jammy 
COPY --from=build-stage /app/target/*.war /usr/local/tomcat/webapps/ecom.war
EXPOSE 8080
