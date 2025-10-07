SHELL := /bin/bash

NAME := PureVision

# Required tools
SASSC := sassc -t expanded
INKSCAPE := /usr/bin/inkscape

BASE := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SRC := $(BASE)/src
BUILD_PATH := $(BASE)/build/$(NAME)

BG_COLOR := #2B3136
BS_COLOR := #434F5B
FG_COLOR := \#B2B9BF

.PHONY: all build assets cinnamon gtk-3 gtk-4 gtk-2 metacity clean

all: build assets cinnamon gtk-2 gtk-3 gtk-4  metacity

build:
	mkdir -p $(BUILD_PATH)
	cp index.theme $(BUILD_PATH)/

assets: build
	@if [ -d "$(BUILD_PATH)/assets" ]; then \
		echo "Assets already exist, skipping generation."; \
	else \
		mkdir -p $(BUILD_PATH)/assets; \
		sed "s/#ff9900/$(FG_COLOR)/g" $(SRC)/assets/assets.svg > $(BUILD_PATH)/assets/tmp.svg; \
		while IFS= read -r i; do \
			echo "Rendering $(BUILD_PATH)/assets/$$i.svg"; \
			$(INKSCAPE) --export-id=$$i --export-id-only --export-plain-svg=$(BUILD_PATH)/assets/$$i.svg $(BUILD_PATH)/assets/tmp.svg >/dev/null; \
			$(INKSCAPE) --export-id=$$i --export-id-only --export-filename=$(BUILD_PATH)/assets/$$i.png $(BUILD_PATH)/assets/tmp.svg >/dev/null; \
		done < $(SRC)/assets/assets.txt; \
#		rm $(BUILD_PATH)/assets/tmp.svg; \
		echo "Assets generated in $(BUILD_PATH)/assets"; \
	fi


cinnamon: assets
	@echo -n "Building for Cinnamon... "
	mkdir -p $(BUILD_PATH)/cinnamon
	$(SASSC) $(SRC)/cinnamon/sass/cinnamon-dark.scss $(BUILD_PATH)/cinnamon/cinnamon.css
	cp -r $(BUILD_PATH)/assets $(BUILD_PATH)/cinnamon/
	cp -r $(SRC)/cinnamon/common-assets $(BUILD_PATH)/cinnamon/
	cp $(SRC)/cinnamon/thumbnail.png $(BUILD_PATH)/cinnamon/
	@echo "Done!"

gtk-2: assets
	mkdir -p $(BUILD_PATH)/gtk-2.0
	cp -r $(SRC)/gtk-2.0/* $(BUILD_PATH)/gtk-2.0/
	cp -r $(BUILD_PATH)/assets $(BUILD_PATH)/gtk-2.0/
	@echo GTK-2.0 files copied.

gtk-3: assets
	@echo -n "Building for GTK 3... "
	mkdir -p $(BUILD_PATH)/gtk-3.0
	$(SASSC) $(SRC)/gtk-3.0/sass/gtk-dark.scss $(BUILD_PATH)/gtk-3.0/gtk.css
	#$(SASSC) $(SRC)/gtk-3.0/sass/gtk-dark.scss $(BUILD_PATH)/gtk-3.0/gtk-dark.css
	cp $(BUILD_PATH)/gtk-3.0/gtk.css $(BUILD_PATH)/gtk-3.0/gtk-dark.css
	cp -r $(BUILD_PATH)/assets $(BUILD_PATH)/gtk-3.0/
	cp $(SRC)/gtk-3.0/thumbnail.png $(BUILD_PATH)/gtk-3.0/
	@echo "Done!"

gtk-4: assets
	@echo -n "Building for GTK 4... "
	mkdir -p $(BUILD_PATH)/gtk-4.0
	$(SASSC) $(SRC)/gtk-4.0/sass/gtk-dark.scss $(BUILD_PATH)/gtk-4.0/gtk.css
	#$(SASSC) $(SRC)/gtk-4.0/sass/gtk-dark.scss $(BUILD_PATH)/gtk-4.0/gtk-dark.css
	cp $(BUILD_PATH)/gtk-4.0/gtk.css $(BUILD_PATH)/gtk-4.0/gtk-dark.css
	cp -r $(BUILD_PATH)/assets $(BUILD_PATH)/gtk-4.0/
	@echo "Done!"


metacity: assets
	mkdir -p $(BUILD_PATH)/metacity-1
	cp -r $(SRC)/metacity-1/* $(BUILD_PATH)/metacity-1/
	cp -r $(BUILD_PATH)/assets $(BUILD_PATH)/metacity-1/
	@echo Metacity files copied.

clean:
	rm -rf $(BUILD_PATH)/*
	@echo Cleaned build directory.
