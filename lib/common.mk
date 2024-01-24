
ifndef MAKO_COMMON_MK
MAKO_COMMON_MK=x

space :=
space := $(space) $(space)
tab :=
tab := $(tab)	$(tab)
define newline


endef

# Avoid the problematic auto-remake of this file.
$(MAKO_ROOT)/common.mk:: ;

endif # MAKO_COMMON_MK

