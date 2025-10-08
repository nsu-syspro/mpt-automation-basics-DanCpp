FROM ubuntu:22.04

# Устанавливаем зависимости
RUN apt-get update && \
    apt-get install -y gcc make jq && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p app

# Рабочая директория
WORKDIR /app

# Копируем весь репозиторий
COPY . .

# Собираем и тестируем
RUN make && make check

# Запускаем приложение

ARG arg
env arg $arg1
ENTRYPOINT ["./build/wordcount"]
CMD [$arg1]