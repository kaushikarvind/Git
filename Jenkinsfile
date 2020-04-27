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
        //stage('SonarQube Analysis'){
          //  steps{
            //    withSonarQubeEnv(credentialsId: 'sonarqube_user', installationName: 'SonarQube'){
              //      sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.6.0.1398:sonar'    
                //}
            //}
        //}
        stage('Maven Build'){
            steps{
                sh 'mvn clean install'
            }
        }
        stage('Publish'){
            steps{
                archiveArtifacts 'target/springboot-petclinic-1.4.1.jar'
                junit 'target/surefire-reports/*.xml'
            }
        }
		stage('DeployToStaging') {
            when {
                branch 'master'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'webserver_login', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    sshPublisher(
                        failOnError: true,
                        continueOnError: false,
                        publishers: [
                            sshPublisherDesc(
                                configName: 'staging',
                                sshCredentials: [
                                    username: "$USERNAME",
                                    encryptedPassphrase: "$USERPASS"
                                ], 
                                transfers: [
                                    sshTransfer(
                                        sourceFiles: 'target/springboot-petclinic-1.4.1.jar',
                                        //removePrefix: 'target/',
                                        //execCommand: 'sudo /usr/bin/systemctl stop train-schedule && rm -rf /opt/train-schedule/* && unzip /tmp/trainSchedule.zip -d /opt/train-schedule && sudo /usr/bin/systemctl start train-schedule'
                                        remoteDirectory: '/tmp/spring-petclinic',
                                        execCommand: 'git 'https://github.com/kaushikarvind/spring-petclinic.git' && sudo cp -y /target/springboot-petclinic-1.4.1.jar && sudo java -jar springboot-petclinic-1.4.1.jar'    
                                    )
                                ]
                            ) 
                        ]
                    )
                }
            }
        }
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                input 'Does the staging environment look OK?'
                milestone(1)
                withCredentials([usernamePassword(credentialsId: 'webserver_login', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    sshPublisher(
                        failOnError: true,
                        continueOnError: false,
                        publishers: [
                            sshPublisherDesc(
                                configName: 'production',
                                sshCredentials: [
                                    username: "$USERNAME",
                                    encryptedPassphrase: "$USERPASS"
                                ], 
                                transfers: [
                                    sshTransfer(
                                        sourceFiles: 'target/springboot-petclinic-1.4.1.jar',
                                        removePrefix: 'target/',
                                        remoteDirectory: '/tmp',
                                        execCommand: 'sudo java -jar springboot-petclinic-1.4.1.jar'
                                        //execCommand: 'sudo /usr/bin/systemctl stop train-schedule && rm -rf /opt/train-schedule/* && unzip /tmp/trainSchedule.zip -d /opt/train-schedule && sudo /usr/bin/systemctl start train-schedule'
                                    )
                                ]
                            )
                        ]
                    )
                }
            }
        }
    }
        //post {
        //success {
          //emailext(
            //subject: "${env.JOB_NAME} [${env.BUILD_NUMBER}] Development Promoted to Master",
            //body: """<p>'${env.JOB_NAME} [${env.BUILD_NUMBER}]' Development Promoted to Master":</p>
            //<p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
            //to: "kaushik.arvind@gmail.com"
          //)
        //}
        //failure {
        //emailext(
          //  subject: "${env.JOB_NAME} [${env.BUILD_NUMBER}] Failed!",
            //body: """<p>'${env.JOB_NAME} [${env.BUILD_NUMBER}]' Failed!":</p>
            //<p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
            //to: "kaushik.arvind@gmail.com"
        //)
        //}
    //}
}
