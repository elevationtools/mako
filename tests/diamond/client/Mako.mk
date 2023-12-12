
include $(MAKO_ROOT)/util.mk

define DEPS
	$(TESTBED_ROOT)/proto
endef

ifeq "$(MAKO_STAGE)" "main"

DEFAULT_TARGETS := genfiles/client_bundle
DEFAULT_PREREQS := source_code.lang2
genfiles/client_bundle:
	@# fake compilation.
	cat $(TESTBED_ROOT)/proto/genfiles/api.pb.lang2 > $@
	cat source_code.lang2 >> $@

endif

include $(MAKO_ROOT)/component.mk

