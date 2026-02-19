FROM alpine:3
LABEL authors="_1BAH_, Kalinin Iwan (koefic.cien@gmail.com)"

ENV PASS="breach"
ENV FENRIR_IN_DOCKER=1

RUN apk add --no-cache  \
        util-linux      \
        git             \
        openssh-client  \
        ca-certificates \
        perl-utils      \
        shellcheck      \
        sudo            \
        wget            \
        bash

RUN echo -e "breach\nbreach" | adduser -s "$(which bash)" fikus && \
    echo "fikus ALL=(ALL)  ALL" >> "/etc/sudoers"

WORKDIR /home/fikus
USER fikus

COPY --chown=fikus:fikus src /home/fikus/fenrir/src
RUN cd /home/fikus/fenrir/src/main/fenrir/cli && \
    echo "$PASS" | sudo -S ./install-fenrir -v && \
    cd && \
    rm -fr /home/fikus/fenrir && \
    git config --global user.email "fikus@example.com" && \
    git config --global user.name  "fikus"

# Keep container running
ENTRYPOINT ["top", "-b"]
