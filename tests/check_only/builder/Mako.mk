
include $(MAKO_ROOT)/util.mk

define CHECK_ONLY_DEPS
	$(TESTBED_ROOT)/internal
endef

ifeq "$(MAKO_STAGE)" "main"

DEFAULT_TARGETS := genfiles/output_file
DEFAULT_PREREQS := builder.code

# This will get rerun if "//internal default" needs to be rerun, but
# "//internal default" shouldn't ever actually run.
genfiles/output_file:
	echo "ran" >> $@

endif # main

include $(MAKO_ROOT)/component.mk

