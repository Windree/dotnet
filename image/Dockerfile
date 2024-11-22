FROM ubuntu:24.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y dotnet8 curl && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash && \
    apt install -y nodejs --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*
ADD files /
ENTRYPOINT ["/entrypoint.sh"]
