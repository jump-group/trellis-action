FROM willhallonline/ansible:2.13-ubuntu-20.04

ENV NODE_VERSION $INPUT_NODE_BUILD_VERSION

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
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENTRYPOINT ["/bin/bash", "-c", "source ~/.nvm/nvm.sh && node /index.js"]