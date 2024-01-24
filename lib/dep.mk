# TODO(naming): Think of a better name than "dep" because the term is already
# used in Mako.  Perhaps "external dep", "external tool", "download", etc.
#
# Callers must implement a targets named $(shell uname -s)-$(shell uname -m) for
# all desired platforms. For example:
# 	Linux-x86_64
#		Darwin-x86_64
#
# Callers can optionally implement a 'smoketest' target which should check to
# make sure the downloaded binary actually runs, and perhaps check that it is
# the rigth version (meaning the PATH is setup properly).
#
# For convenience, .PHONY has already been defined for both of the above.

$(lastword $(MAKEFILE_LIST)):: ;

include $(MAKO_ROOT)/util.mk

ifeq "$(MAKO_STAGE)" "main"

OS_ARCH := $(shell uname -s)-$(shell uname -m)

DEFAULT_TARGETS := genfiles/installed
# One might consider adding $(MAKEFILE_LIST) to the prereqs by default, however
# this can end up causing expensive rebuilds when they often aren't needed.
# Instead, the caller can either add $(MAKEFILE_LIST) themselves, or just call
# `make clean` or `make clean_deps` when needed.
DEFAULT_PREREQS :=
genfiles/installed: 
	$(MAKE) --no-print-directory '$(OS_ARCH)'
	mkdir -p $(dir $@)
	touch $@

.PHONY: $(OS_ARCH)
.PHONY: smoketest
smoketest: genfiles/installed

endif

include $(MAKO_ROOT)/component.mk

