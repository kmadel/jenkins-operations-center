# Docker image for Jenkins Operations Center

FROM kmadel/jenkins-base:1.5
MAINTAINER Kurt Madel <kmadel@cloudbees.com>

# Download jenkins-oc.war
USER jenkins
WORKDIR /usr/lib/jenkins
RUN curl -L -O -w "Downloaded: %{url_effective}\\n" "http://jenkins-updates.cloudbees.com/download/oc/1.609.14.1/jenkins-oc.war"

EXPOSE 8080 22 4001
ENV JENKINS_HOME /var/lib/jenkins

ENTRYPOINT ["java", "-jar", "jenkins-oc.war", "--httpPort=8080"]
CMD ["--prefix=/operations-center"]
