
ifndef MAKO_UTIL_MK
MAKO_UTIL_MK=x

include $(MAKO_ROOT)/internal_util.mk

ifeq "$(.DEFAULT_GOAL)" ""
.DEFAULT_GOAL := default
endif

MAKO_STAGE ?=
DEPS ?=
CHECK_ONLY_DEPS ?=

.PHONY: always
always: ;

MAKOI_EVENTS := genfiles/mako

touch_target = mkdir -p $(dir $@); touch $@

ifeq "$(MAKO_STAGE)" "main"

# Params
# 1: alias (phony)
# 2: targets
# 3: prereqs
#
# $(3) must come last in the prereq list because it might contain a "|" to
# indicate order-only-prerequistes.
define mako_define_target_impl
.PHONY: $(1)
$(1): $(2)
$(2): $(MAKOI_EVENTS)/check/$(1)
$(MAKOI_EVENTS)/check/$(1): \
		$(call expand_deps_to_prereqs, $(DEPS)) \
		$(call expand_deps_to_prereqs, $(CHECK_ONLY_DEPS)) \
		$(3)
	@echo "mako target '$(1)' needs updating due to: $$?"
	touch $$@
endef
mako_define_target = $(eval \
		$(call mako_define_target_impl,$(strip $(1)),$(strip $(2)), $(3)))

endif # main

# Avoid the problematic auto-remake of this file.
$(MAKO_ROOT)/util.mk:: ;

endif # ifndef MAKO_UTIL_MK

