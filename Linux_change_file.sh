#!/bin/bash

watchedDir="/etc/sysconfig/iptables
/bin/*
/usr/*
/etc/hosts
/etc/sysconfig/network
/etc/sysconfig/network-scripts/
/etc/postfix/main.cf
/etc/postfix/master.cf
/etc/ssh/sshd_config
/etc/resolv.conf
/etc/passwd
/etc/group
/etc/shadow
/etc/gshadow
/etc/sysconfig/network-scripts/
/etc/selinux/config
/etc/sudo.conf
/etc/sudoers
/etc/sudoers.d/
/etc/rsyslog.conf
/etc/crontab
/etc/cron.d/
/etc/cron.daily/
/etc/cron.hourly/
/etc/cron.weekly/
/etc/cron.monthly/"

inotifywait -m ${watchedDir} -e modify |
    while read -r file; do
        name=$(stat --format %U $file 2>/dev/null)
        date=$(stat --format %y $file 2>/dev/null)
        fileName=${file/* CREATE /}
        echo "File: '$fileName' By user: $name Date: ${date%.*}" | mail -s "File changed on" $(hostbane) your_email@example.com
    done
