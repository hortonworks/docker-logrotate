FROM gliderlabs/alpine:3.1
MAINTAINER SequenceIQ

RUN apk --update add logrotate
ADD logrotate.conf /etc/logrotate.conf

ADD start.sh /start.sh

CMD ["/start.sh"]
