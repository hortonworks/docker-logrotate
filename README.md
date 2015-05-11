# docker-logrotate
Logrotation for docker containers

## Pull the image from Docker Repository
```bash```
docker pull sequenceiq/logrotate
```

## Building the image
```bash```
docker build --rm -t sequenceiq/logrotate .
```

## Running the image
```bash```
docker run --name=logrotate -d \
    -v /var/lib/docker/containers:/var/lib/docker/containers:rw \
    sequenceiq/logrotate
```

It uses `contab` to schedule log rotation. By default the cron expression is: `0 6 * * *` - that means, it runs every day at 6 am. But you can specify this with setting CRON_EXPR variable. (`-e CRON_EXPR="* * * * *"`). 
Notice that it rotates without considering the file size, in case of you want to use your own configuration, you can add your `logrotate.conf`.

### Example
```bash```
docker run --name=logrotate -d
    -e CRON_EXPR="* * * * *" \
    -v /var/lib/docker/containers:/var/lib/docker/containers:rw \
    -v /my/conf/path/logrotate.conf:/logrotate.conf
    sequenceiq/logrotate
```
