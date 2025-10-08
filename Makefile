NAME := $(shell jq -r .name config.json)
VERSION := $(shell jq -r .version config.json)

SOURCES = $(wildcard src/*.c)
TARGET = build/$(NAME)

all: $(TARGET)

$(TARGET): $(SOURCES) config.json
	@mkdir -p build
	cc -DNAME='"$(NAME)"' -DVERSION='"$(VERSION)"' $< -o $@

clean:
	@rm -rf build

$(SOURCES): config.json

.PHONY: all clean