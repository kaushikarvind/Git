pipeline {
    agent any
	tools {
	    jdk 'JDK'
	    maven 'Maven'
        }
    stages{
        stage('Git Clone or Pull'){
            steps {
                git 'https://github.com/kaushikarvind/spring-petclinic.git'
            }
        }
        stage('SonarQube Analysis'){
            steps{
                withSonarQubeEnv(credentialsId: 'sonarqube_user', installationName: 'SonarQube'){
                    sh 'mvn compile'  
                    sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.6.0.1398:sonar'    
                }
            }
        }
        stage('Maven Build & Package'){
            steps{
                sh 'mvn clean package'
                sh 'rm -f /var/jenkins_home/workspace/PetClinic/petclinic.zip'
                zip zipFile: 'petclinic.zip', archive: true, dir: 'target'
                sh 'chmod 777 petclinic.zip'
                junit 'target/surefire-reports/*.xml'
                //archiveArtifacts 'target/springboot-petclinic-1.4.1.jar'
            }
        }
        stage('Build Docker Image'){
            when {
                branch 'master'
            }
            steps {
                sh 'docker build -t kaushikarvind/petclinic:${BUILD_NUMBER} .'
            }
        }
        stage('Push Docker Image to Docker Hub'){
            when {
                branch 'master'
            }
            steps {
                withDockerRegistry([ credentialsId: "docker_hub_login", url: "" ]) {
                    sh 'docker push kaushikarvind/petclinic:${BUILD_NUMBER}'
                    //sh 'docker push kaushikarvind/petclinic:latest'
                }
            }
        }
        stage('Deploy to Staging '){
            when {
                branch 'master'
            }
            steps {
                sshagent(['client1_login_key']) {
                    sh 'ssh -o StrictHostKeyChecking=no vagrant@192.168.33.10 docker rm -f petclinic || true'
                    sh 'ssh -o StrictHostKeyChecking=no vagrant@192.168.33.10 docker run -d --name petclinic -p 8080:8080 kaushikarvind/petclinic:${BUILD_NUMBER}'
                }
            }
        }    
        stage('Deploy to Prod '){
            when {
                branch 'master'
            }
            steps {
                input 'Does the Staging environment look OK?'
                milestone(1)
                sshagent(['client1_login_key']) {
                    sh 'ssh -o StrictHostKeyChecking=no vagrant@192.168.33.20 docker rm -f petclinic || true'
                    sh 'ssh -o StrictHostKeyChecking=no vagrant@192.168.33.20 docker run -d --name petclinic -p 8080:8080 kaushikarvind/petclinic:${BUILD_NUMBER}'
                }
            }
        }
    }
}
