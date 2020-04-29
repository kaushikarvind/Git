FROM java:8-jdk-alpine
#USER jenkins
RUN chmod 777 var/jenkins_home/workspace/PetClinic/petclinic.zip
WORKDIR /usr/app
RUN mkdir petclinic
COPY var/jenkins_home/workspace/PetClinic/petclinic.zip /usr/app/petclinic/petclinic.zip
RUN cd /usr/app/petclinic
RUN unzip petclinic.zip
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "*.jar"]
