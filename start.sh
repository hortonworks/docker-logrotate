#!/bin/sh

if [ -z "$CRON_EXPR" ]; then
  CRON_EXPR="6 0	* * *"
  echo "CRON_EXPR environment variable is not set. Set to default: $CRON_EXPR"
else
  echo "CRON_EXPR environment variable set to $CRON_EXPR"
fi

echo "$CRON_EXPR	/logrotate.sh" >> /etc/crontabs/root

crond -f
