
include $(MAKO_ROOT)/base.mk

.DEFAULT_GOAL := default

ifeq "$(MAKO_STAGE)" "main"

DEFAULT_TARGETS ?= $(error DEFAULT_TARGETS required)
DEFAULT_PREREQS ?= $(error DEFAULT_PREREQS required (but can be empty))

$(MAKOI_EVENTS)/check/makoi_dep_prereqs: \
		$(call expand_deps_to_prereqs, $(DEPS)) \
		$(call expand_deps_to_prereqs, $(CHECK_ONLY_DEPS))
	touch $@

$(call mako_define_target, default, $(DEFAULT_TARGETS), $(DEFAULT_PREREQS))

.PHONY: deps
deps: default-deps

endif # main


# Avoid the problematic remake of this file.
$(MAKO_ROOT)/component.mk:: ;

