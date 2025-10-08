FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y gcc make jq && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p wordcount-app

WORKDIR /wordcount-app

COPY . .

RUN make && make check

COPY --chmod=755 <<"EOF" /start.sh
#!/bin/bash
APP_NAME=$(jq -r .name config.json)
if [ -f "$@" ]; then
    exec "./build/$APP_NAME" "$@"
else
    echo "$@" | exec "./build/$APP_NAME"
fi
EOF

ENTRYPOINT ["/start.sh"]


