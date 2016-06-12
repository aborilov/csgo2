FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y curl lib32gcc1 && apt-get clean && rm -rf /var/lib/apt/lists

RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
RUN cat /etc/resolv.conf
RUN mkdir -p /opt/steamcmd &&\
    cd /opt/steamcmd &&\
    curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz

RUN mkdir /opt/steamcmd/csgo &&\
    cd /opt/steamcmd/ &&\
    ./steamcmd.sh \
        +login anonymous \
        +force_install_dir /opt/steamcmd/csgo \
        +app_update 740 validate \
        +quit

EXPOSE 27015

WORKDIR /opt/steamcmd/csgo
ENTRYPOINT ["./srcds_run"]
