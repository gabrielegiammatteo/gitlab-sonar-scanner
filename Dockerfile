FROM openjdk:8-jre-alpine

ENV SONAR_SCANNER_VERSION 4.0.0.1744
ENV SONARDIR /var/opt/sonar-scanner-${SONAR_SCANNER_VERSION}
ENV SONARBIN ${SONARDIR}/bin/sonar-scanner

RUN apk add --update --no-cache wget nodejs && \
    cd /var/opt/ && \
    wget  https://bintray.com/sonarsource/SonarQube/download_file?file_path=org%2Fsonarsource%2Fscanner%2Fcli%2Fsonar-scanner-cli%2F${SONAR_SCANNER_VERSION}%2Fsonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip -O sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    rm sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    rm -rf ${SONARDIR}/jre && \
    sed -i -e 's/use_embedded_jre=true/use_embedded_jre=false/' ${SONARBIN} ${SONARBIN}-debug && \
    ln -s ${SONARBIN} /usr/bin/sonar-scanner && \
    apk del wget

COPY sonar-scanner-run.sh /usr/bin/
