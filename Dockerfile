FROM node:12.14.1-stretch

RUN apt-get update -y && \
    apt-get install -y \
            gnupg2 \
            git-core \
            joe \
            curl
 
RUN curl -s -L https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-`uname -s`-`uname -m` -o envsubst && \
    chmod +x envsubst && \
    mv envsubst /usr/local/bin 

#RUN yarn global add @quasar/cli && \
#    yarn global add @quasar/app


COPY nginx/site.conf /etc/nginx/nginx.conf

ENV APP_DIR=/code
WORKDIR $APP_DIR
ENV PATH="/code/node_modules/.bin:${PATH}"
ENV FORWARD_TO_HTTPS=xxxxxxxxxxx

ADD package.json package.json
ADD yarn.lock yarn.lock

RUN yarn install

ADD . $APP_DIR

CMD "/bin/bash"
