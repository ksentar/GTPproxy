FROM ubuntu:20.04

WORKDIR "/app"

RUN apt update && apt install -y curl vim bash-completion

RUN curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | VERSION=v2.8.4 bash

RUN mkdir /etc/bash_completion.d

RUN hasura completion bash --file=/etc/bash_completion.d/hasura

ARG PUID=1000
ARG PGID=1000

# ubuntu
RUN addgroup --system --gid ${PGID} hasura  \
    && adduser --system --ingroup hasura --uid ${PUID} hasura

COPY .bashrc /root/.bashrc
COPY .bashrc /home/hasura/.bashrc
