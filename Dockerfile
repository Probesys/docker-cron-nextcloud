FROM renskiy/cron:debian

LABEL maintainer = "Sébastien Poher <sebastien.poher@probesys.com>"
LABEL name = "Docker cron sidecar"
LABEL description = "Sidecar container for Nextcloud cron tasks"

COPY nextcloud /etc/cron/.d/nextcloud
