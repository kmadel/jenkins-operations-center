# Docker image for Jenkins Operations Center

FROM debian:jessie
MAINTAINER Andrew Pemberton <apemberton@cloudbees.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-7-jdk \
    openssh-server \
    curl

# Create Jenkins user
RUN useradd jenkins
RUN echo "jenkins:jenkins" | chpasswd

# Make directory for JENKINS_HOME and jenkins-oc.war
RUN mkdir /usr/lib/jenkins-oc /var/lib/jenkins-oc

# Download jenkins.war
WORKDIR /usr/lib/jenkins-oc
RUN curl -L -O -w "Downloaded from: %{url_effective}\\n" "http://jenkins-updates.cloudbees.com/download/oc/*latest*/jenkins-oc.war"

# Set permissions
RUN chown -R jenkins:jenkins /usr/lib/jenkins-oc /var/lib/jenkins-oc

EXPOSE 8080 22
ENV JENKINS_HOME /var/lib/jenkins-oc

USER jenkins
CMD ["java", "-jar", "jenkins-oc.war", "--httpPort=8080", "--prefix=/operations-center"]