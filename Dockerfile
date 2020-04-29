FROM java:8-jdk-alpine
WORKDIR /usr/app
RUN mkdir petclinic
ADD petclinic.zip /usr/app/petclinic
RUN cd /usr/app/petclinic && unzip petclinic.zip && mv *.jar petclinic.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "petclinic.jar"]
