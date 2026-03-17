#
# Makefile for thechelsuk.nnwtheme
#

SRC_DIR = ./src
PKG = ./thechelsuk.nnwtheme
DIST_DIR = ./dist
INFO_PATH = $(PWD)/src/Info
VERSION = $(shell defaults read $(INFO_PATH) Version)
ZIP = ./thechelsuk.nnwtheme_v$(VERSION).zip

.DEFAULT: all

.PHONY: all clean install dist tidy

all: dist

dist: clean build tidy

clean:
	-rm -rf $(PKG)

install: clean $(PKG)
	open $(PKG)/.

build: $(PKG) $(ZIP)

tidy:
	-rm -rf $(PKG)

$(PKG):
	mkdir -p $(PKG)
	cp -R $(SRC_DIR)/* $(PKG)/.

$(ZIP):
	mkdir -p $(DIST_DIR)
	zip -r $(DIST_DIR)/$(ZIP) $(PKG)
