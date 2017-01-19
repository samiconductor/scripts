SCRIPTS_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/bin
BIN_SCRIPTS := $(wildcard bin/*)
SCRIPTS := $(BIN_SCRIPTS:bin/%=%)

DEFAULT_PREFIX = ~/.local
PREFIX := $(DEFAULT_PREFIX)

all:
	@echo "Run 'make install' to link scripts into $(PREFIX)/bin"
	@echo "Run 'make uninstall' to unlink scripts $(PREFIX)/bin"
	@echo ""
	@echo "The default prefix is $(DEFAULT_PREFIX)"
	@echo "Run 'make PREFIX=<path> [install|uninstall]' to link the scripts elsewhere"
	@echo "WARNING: Make does not handle spaces in paths!"

install:
	@echo "Linking '$(SCRIPTS)' into $(PREFIX)/bin"
	@echo ""
	mkdir -p $(PREFIX)/bin
	for script in $(SCRIPTS); do \
		ln -sf $(SCRIPTS_DIR)/$$script $(PREFIX)/bin; \
		done

uninstall:
	@echo "Unlinking '$(SCRIPTS)' from $(PREFIX)/bin"
	@echo ""
	for script in $(SCRIPTS); do \
		find $(PREFIX)/bin -maxdepth 1 -name $$script -type l -exec rm {} +; \
		done
