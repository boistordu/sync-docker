# Resilio Sync
#
# VERSION               0.1
#

FROM ubuntu
MAINTAINER Resilio Inc. <support@resilio.com>
LABEL com.resilio.version="2.4.2"

#ADD https://download-cdn.resilio.com/2.4.1/linux-x64/resilio-sync_x64.tar.gz /tmp/sync.tgz
#RUN tar -xf /tmp/sync.tgz -C /usr/bin rslsync && rm -f /tmp/sync.tgz
RUN echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" > /etc/apt/sources.list.d/resilio-sync.list
RUN wget -qO - https://linux-packages.resilio.com/resilio-sync/key.asc | sudo apt-key add -
RUN apt-get update && apt-get install resilio-sync
COPY sync.conf /etc/
COPY run_sync /usr/bin/

EXPOSE 8888
EXPOSE 55555

VOLUME /mnt/sync

ENTRYPOINT ["run_sync"]
CMD ["--config", "/etc/sync.conf"]
