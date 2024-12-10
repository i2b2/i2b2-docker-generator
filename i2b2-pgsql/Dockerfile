from  i2b2/i2b2-pg:local-build-v1

RUN apt-get install && \
    apt-get install -y supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# CMD ["/etc/init.d/postgresql", "start",]
CMD ["supervisord"]