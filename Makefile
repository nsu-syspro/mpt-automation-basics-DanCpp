NAME := $(shell jq -r .name config.json)
VERSION := $(shell jq -r .version config.json)

SOURCES = $(wildcard src/*.c)
TARGET = build/$(NAME)

TEST_INPUT = $(wildcard test/*.txt)
TEST_EXPECTED = $(TEST_INPUT:%.txt=%.expected)
TESTS = $(TEST_INPUT:%.txt=%.test)

all: $(TARGET)

clean:
	@rm -rf build

check: $(TESTS)


$(TARGET): $(SOURCES) config.json
	@mkdir -p build
	cc -DNAME='"$(NAME)"' -DVERSION='"$(VERSION)"' $(SOURCES) -o $@

$(SOURCES): config.json

$(TESTS): %.test : %.txt %.expected $(TARGET)
	@./$(TARGET) <$*.txt | diff -u --color=always $*.expected -

.PHONY: all clean