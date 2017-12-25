FROM alpine

ARG version=EAP_Controller_v2.5.3_linux_x64
ARG package=$version.tar.gz

RUN apk update && apk upgrade && apk add --no-cache --update bash && apk add --no-cache --update libc6-compat

RUN ["/bin/bash", "-c", "wget http://static.tp-link.com/resources/software/$package; \
  tar --directory /tmp --extract --file=$package --gzip --verbose; \
  rm $package; \
  cd /tmp/$version; \
  yes | ./install.sh; \
  cd . \
  rm -R /tmp/$version"]

EXPOSE 8088

CMD ["tpeap start"]
