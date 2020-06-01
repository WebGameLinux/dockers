FROM certbot/certbot:v1.4.0
LABEL maintainer="weblinuxgame <weblinuxgame@126.com>" version="2.0"

ARG timezone

ENV PATh=${PATH}:/opt/certbot \
    TIMEZONE=${timezone:-"Asia/Shanghai"}

EXPOSE 8080
VOLUME /etc/letsencrypt /var/lib/letsencrypt