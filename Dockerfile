FROM alpine:3.3

# build dependencies
RUN apk add --no-cache bash nodejs git openssh-client python make g++

RUN npm install -g aglio apib2swagger

ARG CACHE_DATE=not_a_date
RUN npm install -g  aglio-theme-w00tw00t
