FROM java:8-jdk-alpine
USER root
WORKDIR /usr
RUN mkdir petclinic
ADD petclinic.zip /usr/petclinic
RUN pwd
WORKDIR /usr/petclinic
RUN cd /usr/petclinic && unzip petclinic.zip
RUN ls -lah
RUN mv *.jar petclinic.jar && chmod 777 petclinic.jar
EXPOSE 8080
#ENTRYPOINT ["java", "-jar", "petclinic.jar"]
CMD ls -lah /usr/app/petclinic && whoami
