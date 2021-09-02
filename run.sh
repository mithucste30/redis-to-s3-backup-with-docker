#!/usr/bin/env sh

redis_hostname=${REDIS_HOSTNAME:-"localhost"}
redis_port=${REDIS_PORT:-"6379"}

backup_type="redis"
s3_bucket_name=${S3_BUCKET_NAME:-"binded-backups"}

# just for testing...
# redis-server > /dev/null &
# while ! redis-cli ping; do sleep 1; done;

redis-cli \
  -h "$redis_hostname" \
  -p "$redis_port" \
  --rdb /tmp/dump.rdb

aws s3 cp /tmp/dump.rdb "s3://${s3_bucket_name}/$(date +"%Y-%m-%d")/redis-backup-$(date +"T%H:%M:%SZ").rdb"
