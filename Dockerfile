FROM alpine

ARG version=EAP_Controller_v2.5.3_linux_x64
ARG package=$version.tar.gz

RUN wget http://static.tp-link.com/resources/software/$package; \
  tar --directory /tmp --extract --file=$package --gzip --verbose; \
  rm $package; \
  yes | /tmp/$version/install.sh; \
  rm -R /tmp/$version

EXPOSE 8088

CMD ["tpeap start"]
