FROM alpine:latest

MAINTAINER Matt Knight

RUN apk --no-cache add wget g++ make

RUN wget https://github.com/P-H-C/phc-winner-argon2/archive/20161029.tar.gz --no-check-certificate -O /tmp/argon2.tar.gz
RUN tar zxvf /tmp/argon2.tar.gz -C /tmp && rm /tmp/argon2.tar.gz
RUN mkdir -p /usr/src && mv /tmp/phc-winner-argon2-20161029 /usr/src/argon2

WORKDIR /usr/src/argon2

RUN make && make bench && make test && make install
RUN install bench /usr/bin

RUN apk del wget g++ make

WORKDIR /

CMD ["sh"]