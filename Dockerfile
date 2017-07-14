FROM alpine:3.3

# build dependencies
RUN apk add --no-cache bash nodejs git openssh-client python make g++

RUN npm install -g aglio apib2swagger drakov
RUN curl https://raw.githubusercontent.com/stoplightio/prism/master/install.sh | sh
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk
RUN apk add --allow-untrusted glibc-2.25-r0.apk

ARG CACHE_DATE=not_a_date
RUN npm install -g aglio-theme-peperoncino
ADD . /docs

CMD ["make", "--directory", "/docs", "clean", "drakov-mock"]
