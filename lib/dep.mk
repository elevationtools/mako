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

include $(MAKO_ROOT)/util.mk

ifeq "$(MAKO_STAGE)" "main"

OS_ARCH := $(shell uname -s)-$(shell uname -m)

DEFAULT_TARGETS := genfiles/installed
DEFAULT_PREREQS := Makefile
genfiles/installed: 
	$(MAKE) --no-print-directory '$(OS_ARCH)'
	mkdir -p $(dir $@)
	touch $@

.PHONY: $(OS_ARCH)
.PHONY: smoketest
smoketest: genfiles/installed

endif

include $(MAKO_ROOT)/component.mk

