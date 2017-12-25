FROM alpine

ARG version=EAP_Controller_v2.5.3_linux_x64
ARG package=$version.tar.gz
ARG jre=jre-9.0.1
ARG jv=9.0.1+11
ARG jdist=$jre_linux-x64_bin

RUN apk update && apk upgrade && apk add --no-cache --update bash libc6-compat paxctl

RUN ["/bin/bash", "-c", "wget -header \"Cookie: oraclelicense=accept-securebackup-cookie\" http://download.oracle.com/otn-pub/java/jdk/$jv/$jdist.tar.gz; \
  mkdir -p /opt/java; \
  tar --directory /opt/java --extract --file=$jdist.tar.gz --gzip --verbose; \
  rm $jdist.tar.gz
  ln -s /opt/java/$jre /opt/java/current; \
  export JAVA_HOME=/opt/java/current; \
  export PATH=$PATH:$JAVA_HOME/bin; \
  sh /etc/profile.d/java.sh; \
  cd /opt/java/$jre; \
  paxctl -c java; \
  paxctl -m java"]

RUN ["/bin/bash", "-c", "wget http://static.tp-link.com/resources/software/$package; \
  tar --directory /tmp --extract --file=$package --gzip --verbose; \
  rm $package; \
  cd /tmp/$version; \
  yes | ./install.sh; \
  cd . \
  rm -R /tmp/$version"]

EXPOSE 8088

CMD ["tpeap start"]
