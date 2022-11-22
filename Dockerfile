  
FROM willhallonline/ansible:2.13-alpine-3.16

COPY ./dist/index.js /index.js

# Basic Packages + Sage
RUN apk add --no-cache --virtual .build-deps \
        nodejs yarn rsync \
        g++ make autoconf automake libtool nasm \
        libpng-dev libjpeg-turbo-dev \
    && rm -rf /var/cache/apk/* /tmp/*

RUN apk update && apk add bash

# Install NVM
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash 

RUN source ~/.nvm/nvm.sh; \
    nvm install 12; \
    nvm use --delete-prefix 12;

# Basic smoke test
# RUN echo 'node --version' && node --version && \
#     echo 'yarn versions' && yarn versions && \
#     echo 'python --version' && python --version && \
#     echo 'ansible --version' && ansible --version && \
#     echo 'rsync --version' && rsync --version

# Dont use this, we have everything precompiled
#RUN yarn install --production --silent --non-interactive

ENTRYPOINT ["node", "/index.js"]