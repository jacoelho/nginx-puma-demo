FROM nginx:alpine

ENV RACK_ENV production
ENV PORT 3000

RUN apk --update add \
        --virtual build_deps \
        build-base \
        ruby \
        ruby-dev \
        openssl-dev \
        ruby-bundler \
        ca-certificates && \
    rm -rf /var/cache/apk/* && \
    echo 'gem: --no-document' > /etc/gemrc

COPY Gemfile      /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY demo.rb      /app/demo.rb
COPY default.conf /etc/nginx/conf.d/default.conf

WORKDIR /app

RUN bundle install --deployment --path vendor/

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD [ "/entrypoint.sh"  ]

