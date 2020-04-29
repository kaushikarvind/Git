FROM java:8-jdk-alpine
USER root
WORKDIR /usr
RUN mkdir /usr/petclinic
WORKDIR /usr/petclinic
ADD petclinic.zip /usr/petclinic/
RUN unzip petclinic.zip && mv *.jar petclinic.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "petclinic.jar"]
