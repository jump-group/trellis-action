FROM willhallonline/ansible:2.13-ubuntu-20.04

COPY ./dist/index.js /index.js

# Basic Packages + Sage
# RUN apk add --no-cache --virtual .build-deps \
#         nodejs yarn rsync \
#         g++ make autoconf automake libtool nasm \
#         libpng-dev libjpeg-turbo-dev \
#     && rm -rf /var/cache/apk/* /tmp/*

RUN apt update 

ENV NVM_DIR ~/.nvm
ENV NODE_VERSION 12

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# RUN apk add util-linux pciutils usbutils coreutils binutils findutils grep iproute2

# Basic smoke test
# RUN echo 'node --version' && node --version && \
#     echo 'yarn versions' && yarn versions && \
#     echo 'python --version' && python --version && \
#     echo 'ansible --version' && ansible --version && \
#     echo 'rsync --version' && rsync --version

# Dont use this, we have everything precompiled
#RUN yarn install --production --silent --non-interactive

ENTRYPOINT ["node", "/index.js"]