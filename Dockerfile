
# guide: https://github.com/BitcoinGod/BitcoinGod/blob/master/INSTALL.md

FROM ubuntu:18.04

RUN mkdir -p /opt/coin
WORKDIR /opt/coin

EXPOSE 18886

RUN apt-get update && apt-get install -y wget build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-all-dev software-properties-common
RUN add-apt-repository -y ppa:bitcoin/bitcoin && apt-get update && apt-get install -y libdb4.8-dev libdb4.8++-dev libminiupnpc-dev
# fix https://github.com/BitcoinGod/BitcoinGod/issues/1
RUN apt-get install -y libssl1.0-dev

RUN wget https://github.com/BitcoinGod/BitcoinGod/archive/v0.1.5.0.tar.gz -O - | tar xzf -
RUN cd BitcoinGod-* && ./autogen.sh && ./configure --without-gui && make
RUN cd /opt/coin/BitcoinGod-* && mv src/bitcoingodd src/bitcoingod-cli src/bitcoin-tx /opt/coin/

# cleanup
RUN apt-get autoremove -y && rm -rf /var/lib/apt/lists/* && rm -rf /opt/coin/BitcoinGod-*

VOLUME ["/opt/coin/data", "/opt/coin/coin.conf"]

ENTRYPOINT ["/opt/coin/bitcoingodd"]
CMD ["-conf=/opt/coin/coin.conf"]
