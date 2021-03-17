version: "3"

services:

  jenkins:
    image: resolvn/jenkins:2.262
    container_name: jenkins
    restart: unless-stopped
    volumes:
      - /home/resolvn/docker/jenkins/jenkins_data:/var/jenkins_home
    ports:
      - "8100:8080"
      - "8101:50000"
