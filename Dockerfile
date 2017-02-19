FROM gliderlabs/alpine:3.4

ENV TZ="JST-9"

ENV FFMPEG_VERSION=3.2.4

RUN \ 
      apk update && \

      apk add --no-cache \
      freetype-dev \
      openssl-dev \
      rtmpdump-dev \
      x264-dev \
      yasm-dev \
      zlib-dev \
      && \

      apk add --no-cache --virtual=build-dependencies \
      build-base \
      curl \
      nasm \
      tar \
      bzip2 \
      && \

      DIR=$(mktemp -d) && cd ${DIR} && \

      wget http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz -O - | tar zxvf - -C . && \
      cd ffmpeg-${FFMPEG_VERSION} && \
      ./configure \

      --enable-gpl \
      --enable-version3 \
      --enable-nonfree \

      --enable-small \

      --disable-ffplay \
      --disable-ffserver \

      --disable-doc \
      --disable-htmlpages \
      --disable-manpages \
      --disable-podpages \
      --disable-txtpages \

      --enable-libx264 \
      --enable-postproc \
      --enable-avresample \
      --enable-libfreetype \
      --enable-openssl \
      --disable-debug \
      && \

      make && \
      make install && \
      make distclean && \

      rm -rf ${DIR} && \
      apk del build-dependencies && \
      rm -rf /var/cache/apk/*
