ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache jq xl2tpd nodejs npm supervisor 

# Copy data
COPY run-l2tp.sh /
COPY ui/ /ui/
COPY supervisord.conf /supervisord.conf

RUN chmod a+x /run-l2tp.sh
RUN cd /ui && npm install

CMD ["/usr/bin/supervisord -c /supervisord.conf"]
