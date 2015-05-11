#!/bin/sh

if [ -z "$CRON_EXPR" ]; then
  CRON_EXPR="0 6	* * *"
  echo "CRON_EXPR environment variable is not set. Set to default: $CRON_EXPR"
else
  echo "CRON_EXPR environment variable set to $CRON_EXPR"
fi

echo "$CRON_EXPR	/usr/sbin/logrotate -v -f /etc/logrotate.conf" >> /etc/crontabs/root

crond -f
