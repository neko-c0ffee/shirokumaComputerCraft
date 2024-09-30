FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    && update-ca-certificates

ENTRYPOINT ["/bin/bash"]
