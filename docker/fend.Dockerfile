FROM registry.gitlab.com/atpd/fenrir/fenrir-base:latest AS fenrir

FROM docker:latest
LABEL authors="_1BAH_, Kalinin Iwan (koefic.cien@gmail.com)"

ENV FENRIR_IN_DOCKER=1

RUN apk add --no-cache  \
        git             \
        openssh-client  \
        ca-certificates \
        shellcheck      \
        sudo            \
        wget            \
        bash

RUN echo -e "breach\nbreach" | adduser -s "$(which bash)" fikus && \
    echo "fikus ALL=(ALL)  ALL" >> "/etc/sudoers" && \
    git config --global user.email "fikus@example.com" && \
    git config --global user.name  "fikus"

COPY --from=fenrir /usr/local/bin/fenrir* /usr/local/bin/
COPY --from=fenrir /usr/local/bin/loki /usr/local/bin/
COPY --from=fenrir --chown=fikus:fikus /etc/fenrir /etc/fenrir

WORKDIR /home/fikus
USER fikus
