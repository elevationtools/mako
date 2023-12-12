
include $(MAKO_ROOT)/util.mk

define DEPS
	$(TESTBED_ROOT)/client
	$(TESTBED_ROOT)/server
endef

ifeq "$(MAKO_STAGE)" "main"

DEFAULT_TARGETS := genfiles/deployment_up
DEFAULT_PREREQS := bring_it_up
genfiles/deployment_up:
	./bring_it_up
	touch $@

endif

include $(MAKO_ROOT)/component.mk

