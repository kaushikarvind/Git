FROM java:8-jdk-alpine
WORKDIR /usr/app
RUN mkdir petclinic
COPY petclinic.zip /usr/app/petclinic/petclinic.zip
RUN cd /usr/app/petclinic
RUN unzip petclinic.zip
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "*.jar"]
