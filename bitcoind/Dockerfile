FROM blockstream/bitcoind:0.20.1

RUN mkdir -p /root/.bitcoin/regtest

COPY bitcoin.conf /root/.bitcoin/bitcoin.conf
VOLUME /root/.bitcoin/regtest

EXPOSE 18888 18889

ENTRYPOINT ["/usr/local/bin/bitcoind"]
