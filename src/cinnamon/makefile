SHELL := /bin/bash

DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
BUILD_PATH := $(DIR)/../build/PureVision/cinnamon

SASSC := sassc -t expanded $(DIR)/sass/cinnamon-dark.scss $(BUILD_PATH)/cinnamon.css

.PHONY: build apply

build:
	mkdir -p $(BUILD_PATH)
	$(SASSC)
	cp -r $(DIR)/cinnamon/assets $(BUILD_PATH)/
	cp -r $(DIR)/cinnamon/common-assets $(BUILD_PATH)/
	cp $(DIR)/cinnamon/assets/thumbnail.png $(BUILD_PATH)/
	@echo Build!

apply:
	# gsettings set org.cinnamon.theme name "cinnamon"
	# gsettings set org.cinnamon.theme name "PureVision"
	@echo Apply!
