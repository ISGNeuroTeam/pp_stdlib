#.SILENT:
SHELL = /bin/bash

VERSION := "0.2.1"
BRANCH := $(shell git name-rev $$(git rev-parse HEAD) | cut -d\  -f2 | sed -re 's/^(remotes\/)?origin\///' | tr '/' '_')

clean:
	echo Clean
	for E in $$(ls ./commands); do (cd commands/$$E ; make clean); done
	rm -fr package
	rm -f *.tar.gz

test:
	echo Test

build:
	echo Build
	mkdir -p package/
	rm -fr package/*
	for E in $$(ls ./commands); do (cd commands/$$E ; make pack); tar xf commands/$$E/*tar.gz -C package; done

pack: build
	tar czf pp_stdlib-$(VERSION)-$(BRANCH).tar.gz package/*
