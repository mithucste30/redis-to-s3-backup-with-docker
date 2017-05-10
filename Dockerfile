FROM garland/aws-cli-docker

RUN apk --no-cache update && \
    apk --no-cache add redis && \
    rm -rf /var/cache/apk/*

ADD run.sh /data/run.sh

CMD ["/data/run.sh"]
