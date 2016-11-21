FROM alpine:3.3
RUN apk add --no-cache bash nodejs git openssh-client python make g++
RUN npm install -g aglio
RUN git clone https://github.com/christiangoltz/aglio.git aglio_theme
RUN cd aglio_theme && git checkout w00tw00t_theme
RUN cd aglio_theme && npm install
RUN cd aglio_theme && npm run build && npm install -g
