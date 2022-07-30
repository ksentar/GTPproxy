FROM node:16-alpine

ARG PUID=1000
ARG PGID=1000

# alpine
RUN deluser --remove-home node \
    && addgroup -S node -g ${PUID} \
    && adduser -S -G node -u ${PGID} node

RUN apk add curl

USER node

WORKDIR /app
