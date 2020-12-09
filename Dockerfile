FROM debian:stable-slim
# Update from https://github.com/renskiy/cron-docker-image to Buster

LABEL maintainer = "Sébastien Poher <sebastien.poher@probesys.com>"
LABEL name = "Docker cron sidecar"
LABEL description = "Sidecar container for Nextcloud cron tasks"

RUN set -ex \
    && apt-get update -q --fix-missing && \
    apt-get -y install --no-install-recommends \
    cron \
    php7.3-cli \
    php7.3-curl \
    php7.3-gd \
    php7.3-intl \
    php7.3-mbstring \
    php7.3-mysql \
    php7.3-xml \
    php7.3-zip \
    sudo \
    && rm -rf /var/lib/apt/lists/* \
    # making logging pipe
    && mkfifo --mode 0666 /var/log/cron.log \
    # make pam_loginuid.so optional for cron
    # see https://github.com/docker/docker/issues/5663#issuecomment-42550548
    && sed --regexp-extended --in-place \
    's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' \
    /etc/pam.d/cron

COPY start-cron /usr/sbin
COPY nextcloud /etc/cron.d/nextcloud

CMD [ "start-cron" ]
