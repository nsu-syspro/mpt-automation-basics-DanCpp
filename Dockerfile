FROM ubuntu:22.04

RUN apt-get update && \
  apt-get install -y gcc make jq

COPY . .

RUN make && make check