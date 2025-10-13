FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y gcc make jq && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p wordcount-app

WORKDIR /wordcount-app

COPY . .

RUN make && make check



ENTRYPOINT ["./src/wordcount"]


