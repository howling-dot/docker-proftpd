FROM debian:stretch

MAINTAINER Howling-dot

RUN apt-get update -qq && \
	apt-get install -y proftpd && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY proftpd.conf /etc/proftpd/proftpd.conf 

EXPOSE 20 21 48600-48697

ADD docker-entrypoint.sh /usr/local/sbin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/sbin/docker-entrypoint.sh"]

CMD ["proftpd", "--nodaemon"]
