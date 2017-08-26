FROM gliderlabs/alpine:3.1
MAINTAINER SequenceIQ

RUN apk --update add bash logrotate

ADD start.sh /start.sh

CMD ["/start.sh"]
