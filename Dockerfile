FROM ubuntu:latest
MAINTAINER Andy Pemberton <apemberton@cloudbees.com>

# RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y openjdk-7-jdk openssh-server curl

RUN adduser --quiet jenkins
RUN echo "jenkins:jenkins" | chpasswd

EXPOSE 8080
EXPOSE 22

# USER jenkins
RUN mkdir /var/lib/jenkins
RUN cd /var/lib/jenkins

#temporarily just add from local
ADD jenkins-oc.war /operations-center/jenkins-oc.war
# RUN curl -L -O 'http://jenkins-updates.cloudbees.com/download/oc/*latest*/jenkins-oc.war'
# TODO output tag from 301 redirect for -t 

ENV JENKINS_HOME /operations-center 
WORKDIR /operations-center

CMD ["/bin/bash", "-c", "java -jar jenkins-oc.war --httpPort=8080 --prefix=/operations-center"]