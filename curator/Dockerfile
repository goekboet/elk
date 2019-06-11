FROM gookboet/curator:1.1.1

COPY config/ /srv

COPY cronjobs /etc/crontabs/root

# start crond with log level 8 in foreground, output to stderr
CMD ["crond", "-f", "-d", "8"]