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
        yarn \
    && rm -rf /var/lib/apt/lists/*

# # Install nvm with node and npm
# RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash \
#     && . ~/.nvm/nvm.sh \
#     && nvm install 12 \
#     && nvm alias default 12 \
#     && nvm use default

# Install nodejs 12
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y -q --no-install-recommends yarn

# Install rsync
RUN apt-get update && apt-get install -y -q --no-install-recommends rsync

ENTRYPOINT ["/bin/bash", "-c", "source ~/.nvm/nvm.sh && node /index.js"]