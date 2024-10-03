FROM maven:3.9.9-eclipse-temurin-17 AS build
RUN git clone https://github.com/anitha233/spring-petclinic-oct24.git
RUN cd spring-petclinic-oct24 && mvn clean package

FROM amazoncorretto:17-alpine3.17-jdk
RUN adduser -D spc
RUN mkdir spc1 && chown spc /spc1
USER spc
WORKDIR /spc1
COPY --from=build --chown=spc:spc  /spring-petclinic-oct24/target/spring-petclinic-3.3.0-SNAPSHOT.jar /spc1/spring-petclinic.jar
EXPOSE 8080
CMD ["java", "-jar","spring-petclinic.jar"]


