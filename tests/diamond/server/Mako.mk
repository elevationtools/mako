
include $(MAKO_ROOT)/util.mk

define DEPS
	$(TESTBED_ROOT)/proto
endef

ifeq "$(MAKO_STAGE)" "main"

DEFAULT_TARGETS := genfiles/server_bin
DEFAULT_PREREQS := source_code.lang1
genfiles/server_bin:
	@# fake compilation.
	cat $(TESTBED_ROOT)/proto/genfiles/api.pb.lang1 > $@
	cat source_code.lang1 >> $@

endif

include $(MAKO_ROOT)/component.mk

