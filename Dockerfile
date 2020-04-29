FROM java:8-jdk-alpine
RUN mkdir /usr/app/petclinic
WORKDIR /usr/app/petclinic
COPY petclinic.zip /usr/app/petclinic
RUN unzip petclinic.zip
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "*.jar"]
