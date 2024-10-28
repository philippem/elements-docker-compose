FROM blockstream/elementsd:23.2.3

COPY wait-for-it.sh /usr/local/bin/wait-for-it.sh
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN mkdir -p /root/.elements/elementsregtest
COPY elements.conf /root/.elements/elements.conf

ENTRYPOINT ["/docker-entrypoint.sh"]
