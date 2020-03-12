#############################################################################
#
# Makefile for building hwlib in a docker container, uploading to arduino
# and running a native terminal
#
# Copyright (c) R2D2 leads 2020 (r2d2-leads@hu.nl)
# 
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at 
# http://www.boost.org/LICENSE_1_0.txt)
# 
#############################################################################


## DOCKER IMAGE SETTINGS
DOCKER_IMAGENAME 		:= nathanhouwaart/r2d2_buildenvironment
DOCKER_IMAGEVERSION		:= 1.0
DOCKER_IMAGE 			:= $(DOCKER_IMAGE):$(DOCKER_IMAGEVERSION)


ifeq ($(OS),Windows_NT)
	BOSSAC		:= $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR)/programs/bossac/bossac_windows.exe
	BOOTMODE	:= $(BOSSAC) -a --port=$(SERIAL_PORT)
	SUDO   		:=
	TERMINAL 	:= $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR)/programs/terminal/terminal_windows.exe
	BOSSAC_PORT := $(SERIAL_PORT)
	POST_UPLOAD := $(SUDO) $(BOSSAC) --port=$(SERIAL_PORT) -R
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		BOSSAC 		:= $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR)/programs/bossac/bossac_mac.exe
		BOOTMODE	:= $(BOSSAC) -a --port=$(SERIAL_PORT)
		TERMINAL 	:= $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR)/programs/terminal/terminal_mac.exe
		BOSSAC_PORT := $(SERIAL_PORT)
		POST_UPLOAD := 
	else
		BOSSAC 		:= $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR)/programs/bossac/bossac_linux.exe
		BOOTMODE 	:= stty -F $(SERIAL_PORT) speed 1200 cs8 -cstopb -parenb; sleep 1.0
		TERMINAL 	:= $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR)/programs/terminal/terminal_linux.exe
		BOSSAC_PORT := $(subst /dev/,,$(SERIAL_PORT))
		POST_UPLOAD := 
	endif

	SUDO	:= sudo
endif

TARGET_MAKEFILE_DIR 	:= $(abspath $(firstword $(MAKEFILE_LIST)))
TARGET_MAKEFILE_DIR		:= $(notdir $(patsubst %/,%,$(dir $(TARGET_MAKEFILE_DIR))))
	

.phony: run clean clean_container terminal build upload terminal

run: build upload terminal 

build:
	$(SUDO) docker run --rm -it -v $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR):/usr/src/myapp -w /usr/src/myapp/$(MODULE_MAKEFILE_DIR)/$(MODULE_NAME)/$(TARGET_MAKEFILE_DIR) nathanhouwaart/r2d2_buildenvironment:1.0 make --makefile=Makefile.docker build TARGET_DIRECTORY=$(TARGET_DIRECTORY) CONSOLE_BAUDRATE=$(CONSOLE_BAUDRATE) SERIAL_PORT=$(SERIAL_PORT)

upload:
	$(SUDO) $(BOOTMODE)
	$(SUDO) $(BOSSAC) --port=$(BOSSAC_PORT) -Ufalse -e -w -v -b main.bin
	$(POST_UPLOAD)

terminal:
	$(SUDO) $(TERMINAL) -termonly $(SERIAL_PORT) $(CONSOLE_BAUDRATE) 84000

clean:
	$(SUDO) docker run --rm -it -v $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR):/usr/src/myapp -w /usr/src/myapp/$(MODULE_MAKEFILE_DIR)/$(MODULE_NAME)/$(TARGET_MAKEFILE_DIR) nathanhouwaart/r2d2_buildenvironment:1.0 make --makefile=Makefile.docker clean TARGET_DIRECTORY=$(TARGET_DIRECTORY) CONSOLE_BAUDRATE=$(CONSOLE_BAUDRATE) SERIAL_PORT=$(SERIAL_PORT)

clean_container:
	docker rm $(shell docker ps -a -q)