
include $(MAKO_ROOT)/util.mk

ifeq "$(MAKO_STAGE)" "main"

DEFAULT_TARGETS := genfiles/output
DEFAULT_PREREQS := pseudo_source
genfiles/output:
	mkdir -p genfiles
	bash < ./pseudo_source > $@

endif

include $(MAKO_ROOT)/component.mk

