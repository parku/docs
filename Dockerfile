FROM alpine:3.3

# build dependencies
RUN apk add --no-cache bash nodejs git openssh-client python make g++

# aglio for rendering api blueprints and apib2swagger as converter
RUN npm install -g aglio apib2swagger aglio-theme-w00tw00t
