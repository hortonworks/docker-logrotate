FROM gliderlabs/alpine:3.1
MAINTAINER SequenceIQ

RUN apk --update add logrotate jq
ADD logrotate.conf /logrotate.conf

ADD start.sh /start.sh
ADD logrotate.sh /logrotate.sh

CMD ["/start.sh"]
