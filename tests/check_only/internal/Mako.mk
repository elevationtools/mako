
include $(MAKO_ROOT)/util.mk

ifeq "$(MAKO_STAGE)" "main"

DEFAULT_TARGETS := genfiles/never_actually_built
DEFAULT_PREREQS := internal.code

genfiles/never_actually_built:
	echo THIS SHOULD NEVER HAPPEN > /dev/stderr
	exit 1
	cat input.code > $@

endif # main

include $(MAKO_ROOT)/component.mk

