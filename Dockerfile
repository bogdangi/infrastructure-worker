FROM alpine:3.8

MAINTAINER Bogdan Girman (bogdan.girman@gmail.com)

RUN apk update && \
        apk add --no-cache \
                bash \
                curl \
                git \
                openssh-client \
                perl-utils \
                && \
        git clone https://github.com/tfutils/tfenv.git ~/.tfenv && \
        echo 'PATH=${HOME}/.tfenv/bin:${PATH}' >> ~/.bashrc && \
        git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv && \
        echo 'PATH=${HOME}/.tgenv/bin:${PATH}' >> ~/.bashrc && \
        rm -rf /var/cache/apk/*

COPY tf-versions-to-install tf-versions-to-install
RUN . ~/.bashrc && cat tf-versions-to-install | xargs -n 1 -P 10 tfenv install

COPY tg-versions-to-install tg-versions-to-install
RUN . ~/.bashrc && cat tg-versions-to-install | xargs -n 1 -P 10 tgenv install

WORKDIR /root

ENTRYPOINT ["/bin/bash"]
