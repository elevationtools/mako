
ifndef MAKO_INTERNAL_UTIL_MK
MAKO_INTERNAL_UTIL_MK=x

include $(MAKO_ROOT)/common.mk

escape_deps = $(subst |,$(space),$(subst $(space),+,$(subst |$(space),|,$(strip $(subst $(newline),|,$(1))))))

unescape_depline = $(subst +,$(space),$(1))
dir_from_depline  = $(firstword $(call unescape_depline, $(1)))
remove_first = $(wordlist 2, $(words $(1)), $(1))
targets_from_depline = \
		$(strip $(call remove_first, $(call unescape_depline, $(1))))
targets_from_depline_expanded = \
	$(or $(strip $(call targets_from_depline, $(1))), default)

expand_deps_to_prereqs = $(sort $(strip \
	$(foreach depline, $(call escape_deps,$(1)), \
		$(foreach target, $(call targets_from_depline_expanded, $(depline)), \
			$(call dir_from_depline, $(depline))/$(MAKOI_EVENTS)/check/$(target) ))))


# Avoid the problematic auto-remake of this file.
$(MAKO_ROOT)/internal_util.mk: ;

endif # MAKO_INTERNAL_UTIL_MK

