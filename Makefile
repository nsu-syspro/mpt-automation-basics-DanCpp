NAME = $(shell jq -r .name config.json)
VERSION = $(shell jq -r .version config.json)

SOURCES = $(wildcard src/*.c)
BINARIES = $(patsubst src/%.c,build/%, $(SOURCES))

TESTS_INPUTS = $(wildcard test/*.txt)
TESTS_EXPECTED = $(TESTS_INPUTS: %.txt, %.expected)
TESTS = $(TESTS_INPUTS: %.txt, %.test)



all: create_dir $(BINARIES)

create_dir:
	@if [ ! -d ./build ]; then \
		mkdir build; \
	fi

check: $(TESTS)

clean: 
	@rm -rf build
	@echo "clean up..."


$(BINARIES): $(SOURCES)
	cc -DNAME='"$(NAME)"' -DVERSION='"$(VERSION)"' $< -o $@

.PHONY: all check clean