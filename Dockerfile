FROM gazebo:gzserver11

ENV NODE_VERSION 10.14.1
ENV ARCH x64

COPY sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -q -y --no-install-recommends \
  libjansson-dev libboost-dev imagemagick libtinyxml-dev mercurial cmake build-essential \
    ca-certificates curl pkg-config psmisc libgazebo11-dev python2 python-is-python2\
  && rm -rf /var/lib/apt/lists/* \
  && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
  && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

WORKDIR /usr/src/app

COPY . .

RUN npm config set registry https://registry.npmmirror.com 
RUN npm run deploy --- -m local
