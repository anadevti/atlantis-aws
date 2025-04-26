FROM ghcr.io/runatlantis/atlantis:latest

USER root
RUN apk add --no-cache aws-cli && \
    mkdir -p /home/atlantis/.aws && \
    touch /home/atlantis/.aws/credentials && \
    chown -R atlantis:atlantis /home/atlantis

USER atlantis