FROM java:8-jdk-alpine
WORKDIR /home/vagrant/
#ADD https://gitlab.com/kaushikarvind/petclinic/-/tree/master/target/*.jar /usr/app/
RUN git clone https://github.com/kaushikarvind/spring-petclinic.git
COPY target/spring-petclinic*.jar ~/spring-petclinic/target/sprint-petclinic.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "*.jar"]
