FROM fluent/fluentd:v1.7.4-1.0
MAINTAINER Shane Parker
USER root
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

RUN set -ex \
    && apk update && apk upgrade \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        ruby-dev \
        libffi-dev \
    && echo 'gem: --no-document' >> /etc/gemrc \
    && gem install fluent-plugin-prometheus \
    && gem install fluent-plugin-rewrite-tag-filter \
    && gem install fluent-plugin-elasticsearch \
    && gem install fluent-plugin-grok-parser \
    && apk del .build-deps \
    && gem sources --clear-all \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

# Copy files
COPY ./fluent.conf /fluentd/etc/
COPY entrypoint.sh /fluentd/entrypoint.sh

# Environment variables
ENV FLUENTD_OPT=""
ENV FLUENTD_CONF="fluent.conf"

# jemalloc is memory optimization only available for td-agent
# td-agent is provided and QA'ed by treasuredata as rpm/deb/.. package
# -> td-agent (stable) vs fluentd (edge)
#ENV LD_PRELOAD="/usr/lib/libjemalloc.so.2"

# Run Fluentd
CMD ["/fluentd/entrypoint.sh"]
