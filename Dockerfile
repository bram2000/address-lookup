FROM alpine:latest

WORKDIR /root

RUN apk --no-cache add ca-certificates wget bash
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk
RUN apk add glibc-2.29-r0.apk

RUN set -o pipefail && wget -q -O- https://artefacts.tax.service.gov.uk/artifactory/webstore-local/slugs/address-lookup/address-lookup_4.34.0_0.5.2.tgz | tar -zxv

ENV JAVA_HOME /root/.jdk
ENV PATH $JAVA_HOME/bin:/root/:$PATH
ENV HMRC_CONFIG -Delastic.uri="elasticsearch://elasticsearch:9300" -Delastic.cannedData=true

CMD ["bash", "start-docker.sh"]
