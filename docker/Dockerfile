FROM debian:stretch
LABEL maintainer="GreenRenovatedBonds Developers <dev@greenrenovatedbonds.org>"
LABEL description="Dockerised GreenRenovatedBondsCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
