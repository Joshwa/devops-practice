#!/bin/bash

log_dir=~/.log_archive

if [ ! -d "$log_dir" ]; then
    mkdir $log_dir
fi

tar -cvf $log_dir/logs_archive_$(date '+%Y%m%d_%H%M%S').tar.gz $1