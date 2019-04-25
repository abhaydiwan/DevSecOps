node {
   def mvnHome
   def jdk
   stage('Prepare') {
      git url: 'git@github.com:abhaydiwan/DevSecOps.git', branch: 'jenkinsfile_setup'
      mvnHome = tool 'Maven'
      jdk = tool name: 'Java', type: 'jdk'
      env.JAVA_HOME = "${jdk}"
   
   }
   stage('Build') {
      if (isUnix()) {
         sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
      } else {
         bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
      }
   }
   stage('Unit Test') {
      junit '**/target/surefire-reports/TEST-*.xml'
      archive 'target/*.jar'
   }
   stage('Integration Test') {
     if (isUnix()) {
        sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean verify"
     } else {
        bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean verify/)
     }
   }
   stage('Sonar') {
      if (isUnix()) {
         sh "'${mvnHome}/bin/mvn' sonar:sonar"
      } else {
         bat(/"${mvnHome}\bin\mvn" sonar:sonar/)
      }
   }
   stage('Deploy') {
      
       bat(/"move target\*.war target\devsecops.war"/)
       bat(/"cd target"/)
           
       bat(/"curl -u abhay:abhay -T devsecops.war 'http://localhost:8080/manager/text/deploy?path=/devops&update=true'"/)
   }
   stage("Smoke Test"){
       bat(/"curl --retry-delay 10 --retry 5 'http://localhost:8080/devops'"/)
   }
}
