FROM alpine:3.10.3
MAINTAINER Hortonworks

RUN apk --update add bash logrotate

ADD start.sh /start.sh

CMD ["/start.sh"]
