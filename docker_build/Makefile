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

## ---- uren op 09-03-20 ---- ##
# vergadering 13:00 - 14:24
# uren gewerkt aan makefile 14:30 - 16:00
# uren gewerkt aan dit: 20.15 - 00:40


## ---- uren op 10-03-20 ---- ##
# werken aan docker en windows 10 pro licence van 11:45 - 12:30
# vergadering van team 1 -> build environment van vorig jaar getest  12:30 -> 14:00
# weken aan docker makefile voor leads -> kijken of build environment van vorig jaar nog werkt in de docker container 14:00 -> 17:00
# weken aan docker makefile voor leads -> kijken of build environment van vorig jaar nog werkt in de docker container 21:20 -> 22:50

## ---- uren op 11-03-20 ---- ##
## -- werken aan docker makefile 10:00 - 11:00
## -- werken aan docker makefile 13:20 - 16:22 ->  makefile voor windows werkt nu!!!!
## -- werken aan docker makefile voor linux 17:00 - 17: 35
## -- werken aan docker makefile voor linux 18:30 - nu


## DOCKER IMAGE SETTINGS
DOCKER_IMAGENAME 		:= nathanhouwaart/r2d2_buildenvironment
DOCKER_IMAGEVERSION		:= 1.0
DOCKER_IMAGE 			:= $(DOCKER_IMAGE):$(DOCKER_IMAGEVERSION)


ifeq ($(OS),Windows_NT)
	BOSSAC		:= $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR)/programs/bossac/bossac_windows.exe
	BOOTMODE	:= $(BOSSAC) -a --port=$(SERIAL_PORT)
	SUDO   		:=
	TERMINAL 	:= $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR)/programs/terminal/terminal_windows.exe
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		BOSSAC 		:= $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR)/programs/bossac/bossac_mac.exe
		BOOTMODE	:= $(BOSSAC) -a --port=$(SERIAL_PORT)
		TERMINAL 	:= $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR)/programs/bmptk/tools/terminal_mac.exe
	else
		BOSSAC 		:= $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR)/programs/bossac/bossac_linux.exe
		BOOTMODE   	:= stty -F $(SERIAL_PORT) speed 1200 cs8 -cstopb -parenb; sleep 1.0
		TERMINAL 	:= $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR)/programs/bmptk/tools/terminal_linux.exe
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
	$(SUDO) $(BOSSAC) --port=ttyACM0 -Ufalse -e -w -v -b main.bin -R
#$(SUDO) $(BOSSAC) --port=$(SERIAL_PORT) -R

terminal:
	$(SUDO) $(TERMINAL) -termonly $(SERIAL_PORT) $(CONSOLE_BAUDRATE) 84000

clean:
	$(SUDO) docker run --rm -it -v $(R2D2_ROOT_DRIVE)$(R2D2_ROOT_DIR):/usr/src/myapp -w /usr/src/myapp/$(MODULE_MAKEFILE_DIR)/$(MODULE_NAME)/$(TARGET_MAKEFILE_DIR) nathanhouwaart/r2d2_buildenvironment:1.0 make --makefile=Makefile.docker clean TARGET_DIRECTORY=$(TARGET_DIRECTORY) CONSOLE_BAUDRATE=$(CONSOLE_BAUDRATE) SERIAL_PORT=$(SERIAL_PORT)

clean_container:
	docker rm $(shell docker ps -a -q)