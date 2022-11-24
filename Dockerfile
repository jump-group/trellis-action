FROM willhallonline/ansible:2.13-ubuntu-20.04

SHELL ["/bin/bash", "--login", "-c"]

COPY ./dist/index.js /index.js

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash \
    && . ~/.nvm/nvm.sh \
    && nvm install 12 \
    && nvm alias default 12 \
    && nvm use default

ENTRYPOINT ["/bin/bash", "-c", "source ~/.nvm/nvm.sh && node /index.js"]