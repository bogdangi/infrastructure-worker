FROM alpine:3.8

MAINTAINER Bogdan Girman (bogdan.girman@gmail.com)

RUN apk update && \
        apk add --no-cache \
                bash \
                curl \
                git \
                perl-utils \
                && \
        git clone https://github.com/tfutils/tfenv.git ~/.tfenv && \
        echo 'PATH=${HOME}/.tfenv/bin:${PATH}' >> ~/.bashrc && \
        git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv && \
        echo 'PATH=${HOME}/.tgenv/bin:${PATH}' >> ~/.bashrc && \
        . ~/.bashrc && \
        apk del \
                git \
                && \
        rm -rf /var/cache/apk/*

RUN /root/.tfenv/bin/tfenv list-remote | xargs -n 1 -P 10 /root/.tfenv/bin/tfenv install

RUN /root/.tgenv/bin/tgenv list-remote | xargs -n 1 -P 10 /root/.tgenv/bin/tgenv install

WORKDIR /root

ENTRYPOINT ["/bin/bash"]
