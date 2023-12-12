
include $(MAKO_ROOT)/base.mk

ifeq "$(MAKO_STAGE)" "main"

DEFAULT_TARGETS ?= $(error required)
DEFAULT_PREREQS ?= $(error required)

$(MAKOI_EVENTS)/check/makoi_dep_prereqs: \
		$(call expand_deps_to_prereqs, $(DEPS)) \
		$(call expand_deps_to_prereqs, $(CHECK_ONLY_DEPS))
	touch $@

$(call mako_define_target, default, $(DEFAULT_TARGETS), $(DEFAULT_PREREQS))

endif # main


# Avoid the problematic remake of this file.
$(MAKO_ROOT)/component.mk:: ;

