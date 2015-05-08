#!/bin/sh

basedir=/var/lib/docker/containers/
destdir=/var/log/docker-archive/
config_file=/etc/logrotate.conf

> ${config_file}

subfolders=$(find ${basedir} -type d)

for subf in ${subfolders}
do
  subf_rel=${subf:${#basedir}}
  if [ -n "$subf_rel" ]; then
    archive_name=$(jq .Name ${basedir}${subf_rel}/config.json | sed -e 's/^"\///'  -e 's/"$//')
    archive_id=$(jq .ID ${basedir}${subf_rel}/config.json | sed -e 's/^"//'  -e 's/"$//' | cut -c 1-12)

    if [ -z "$archive_name" ]; then
       echo "Failed to retrieve the Name of the container: $subf_rel"
       continue
    fi
    if [ -z "$archive_id" ]; then
       echo "Failed to retrieve the ID of the container: $subf_rel"
       continue
    fi

    archive_dir=${archive_name}-${archive_id}
    props=$(cat /logrotate.conf)
    echo -e "${basedir}${subf_rel}/*.log {
        olddir ${destdir}${archive_dir}/
        $props
    }" >> ${config_file}
  fi
  [ -d ${destdir}${archive_dir} ] || mkdir ${destdir}${archive_dir}
done

/usr/sbin/logrotate -v -f /etc/logrotate.conf
