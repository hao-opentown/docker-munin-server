FROM ubuntu:14.04

MAINTAINER Leo Unbekandt <leo@scalingo.com>

RUN adduser --system --home /var/lib/munin --shell /bin/false --uid 1103 --group munin

RUN apt-get update -qq && RUNLEVEL=1 DEBIAN_FRONTEND=noninteractive \
    apt-get install -y -qq cron munin munin-node apache2-utils wget heirloom-mailx
RUN mkdir -p /var/cache/munin/www && chown munin:munin /var/cache/munin/www && mkdir -p /var/run/munin && chown -R munin:munin /var/run/munin

VOLUME /var/lib/munin
VOLUME /var/cache/munin/www
VOLUME /var/log/munin

ADD ./munin.conf /etc/munin/munin.conf
ADD ./start-munin.sh /munin

#EXPOSE 8080
CMD bash /munin

