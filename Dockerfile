FROM java:8-jdk-alpine
USER root
WORKDIR /usr
RUN mkdir /usr/petclinic && ls -ltr
WORKDIR /usr/petclinic
ADD petclinic.zip /usr/petclinic/
RUN pwd && ls -ltr
#WORKDIR /usr/petclinic
RUN unzip petclinic.zip
RUN ls -lah
RUN mv *.jar petclinic.jar
RUN ls -lah
#&& chmod 777 petclinic.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "petclinic.jar"]
