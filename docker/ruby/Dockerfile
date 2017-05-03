FROM alpine:latest
LABEL maintainer "Steffen Uhlig <Steffen.Uhlig@de.ibm.com>"

RUN apk add --no-cache                         \
      build-base                               \
      ca-certificates                          \
      ruby                                     \
      ruby-dev                                 \
      ruby-io-console                          \
      ruby-rdoc                                \
      ruby-irb                                 \
      ruby-rake                                \
      ruby-bigdecimal                          \
      ruby-json                                \
  && rm -rf /var/cache/apk/*                   \
  && rm -rf /usr/local/lib/ruby/gems/*/cache/* \
  && rm -rf ~/.gem

RUN gem install bundler --no-rdoc
RUN bundle config --global silence_root_warning 1
