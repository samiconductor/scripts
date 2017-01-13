SCRIPTS_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/bin
BIN_SCRIPTS := $(wildcard bin/*)
SCRIPTS := $(BIN_SCRIPTS:bin/%=%)

DEFAULT_PREFIX = ~/.local/bin
PREFIX := $(DEFAULT_PREFIX)

all:
	@echo "Run 'make install' to link scripts"
	@echo "Run 'make uninstall' to unlink scripts"
	@echo ""
	@echo "The default install directory is $(DEFAULT_PREFIX)"
	@echo "Run 'make PREFIX=<path> [install|uninstall]' to link the scripts elsewhere"
	@echo "WARNING: Make does not handle spaces in paths!"

install:
	@echo "Linking '$(SCRIPTS)' into $(PREFIX)"
	@echo ""
	mkdir -p $(PREFIX)
	for script in $(SCRIPTS); do \
		ln -sf $(SCRIPTS_DIR)/$$script $(PREFIX); \
		done

uninstall:
	@echo "Unlinking '$(SCRIPTS)' from $(PREFIX)"
	@echo ""
	for script in $(SCRIPTS); do \
		find $(PREFIX) -maxdepth 1 -name $$script -type l -exec rm {} +; \
		done
