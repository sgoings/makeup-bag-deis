# DEPENDENCIES
#

PROJECT_NAME ?= $(shell basename $(shell pwd))
VERSION ?= $(shell git describe --tags --always --abbrev=0 2>/dev/null)

.PHONY: info info-hook
info: project-info info-hook

.PHONY: project-info
project-info:
	@echo
	@echo Project Info
	@echo -----------
	@echo "Project Name:  		${PROJECT_NAME}"
	@echo "Version:    		${VERSION}"
	@echo

FORCE:
