FROM alpine:3
LABEL authors="_1BAH_, Kalinin Iwan (koefic.cien@gmail.com)"

ENV PASS="breach"
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
    echo "fikus ALL=(ALL)  ALL" >> "/etc/sudoers"

WORKDIR /home/fikus
USER fikus

ARG CACHEBUST
ARG fenrir_branch

RUN git clone -b "$fenrir_branch" https://gitlab.com/atpd/fenrir /home/fikus/fenrir && \
    cd /home/fikus/fenrir/src/main/fenrir/cli && \
    echo "$PASS" | sudo -S ./install-fenrir -v && \
    cd && \
    rm -fr /home/fikus/fenrir && \
    git config --global user.email "fikus@example.com" && \
    git config --global user.name  "fikus"

# Keep container running
ENTRYPOINT ["top", "-b"]
