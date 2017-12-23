FROM alpine

ARG package=EAP_Controller_v2.5.3_linux_x64.tar.gz

RUN curl http://static.tp-link.com/resources/software/$package; \
  tar -zxvf -C tmp $package; \
  tmp/install.sh; \
  rm $package; \
  rm -R tmp

EXPOSE 8088

CMD ["tpeap start"]
