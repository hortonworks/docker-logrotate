# docker-logrotate
Logrotation for docker containers

## Building the image
```bash```
docker build --rm -t sequenceiq/logrotate .
```

## Running the image
```bash```
docker run --name=logrotate -d -v /var/lib/docker/containers:/var/lib/docker/containers:rw sequenceiq/logrotation
```

This will rotate container logs and save them into `/var/log/docker-archive` (in the container). You are able to add a volume to store logs on the host. (`-v /my/local/filesystem/archives:/var/log/docker-archive` )
It uses `contab` to schedule log rotation. By default the cron expression is: `0 6 * * *` - that means, it runs every day at 6 am. But you can specify this with setting CRON_EXPR variable. (`-e CRON_EXPR="* * * * *"`). 
Notice that it rotates without considering the file size, in case of you want to use your own configuration, you can add your `logrotate.conf` (it is not the same as usal logrotate.conf files, it contains only the properties).

### Example
```bash```
docker run --name=logrotate -d
    -e CRON_EXPR="* * * * *" \
    -v /var/lib/docker/containers:/var/lib/docker/containers:rw \
    -v /my/local/filesystem/archives:/var/log/docker-archive \
    -v /my/conf/path/logrotate.conf:/logrotate.conf
    sequenceiq/logrotation
```
