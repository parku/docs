FROM alpine:3.3

# build dependencies
RUN apk add --no-cache bash nodejs git openssh-client python make g++

RUN npm install -g aglio apib2swagger
RUN curl https://raw.githubusercontent.com/stoplightio/prism/master/install.sh | sh
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/unreleased/glibc-2.23-r3.apk
RUN apk add --allow-untrusted glibc-2.23-r3.apk

ARG CACHE_DATE=not_a_date
RUN npm install -g aglio-theme-w00tw00t
ADD . /docs

CMD cd /docs && make clean && make mock
