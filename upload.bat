move target\*.war target\dev.war
C:\DevOpsTools\curl\bin\curl -u abhay:abhay -T target\dev.war "http://localhost:8080/manager/text/deploy?path=/devops&update=true"
