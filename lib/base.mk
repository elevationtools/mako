
include $(MAKO_ROOT)/util.mk
include $(MAKO_ROOT)/internal_util.mk

#### Public Interface ####

# All DEPS will have "make" called on them before entering the "main" stage.
DEPS ?=

BASIC_DEPS ?=

# All CHECK_ONLY_DEPS will have "make $(MAKOI_EVENTS)/check/${target_name}"
# called on them before entering the "main" stage (which propagates to
# transitive DEPS and CHECK_ONLY deps). This means that CHECK_ONLY_DEPS and
# transitive CHECK_ONLY_DEPS and DEPS behind them won't be built, rather they
# will just be checked if they need to be built.
CHECK_ONLY_DEPS ?=

# clean_genfiles is used by callers in some weird cases.
.PHONY: clean clean_genfiles
clean: clean_genfiles
clean_genfiles:
	-rm -rf genfiles

#### End Interface ####

# *DEPS have multiple lines and potentially spaces embedded in the line.
# Instead, we need each line to be able to be passed as a prerequiste stem, so
# the new lines become spaces, and the spaces become pluses.
#
# A string resulting from escaping a single line is referred to as a "depline"
# throughout this library.
DEPS_escaped := $(call escape_deps,$(DEPS))
BASIC_DEPS_escaped := $(call escape_deps,$(BASIC_DEPS))
CHECK_ONLY_DEPS_escaped := $(call escape_deps,$(CHECK_ONLY_DEPS))

ifndef MAKO_STAGE

# This is the main build rule. It forwards to the rule of the same name but
# with the flock held.  Both checkable and basic targets flow through this.
%: $(MAKOI_EVENTS)/built $(MAKOI_EVENTS)/check %-deps
	MAKO_STAGE=main flock ./ $(MAKE) --no-print-directory $@

%-deps: always \
				$(foreach x, $(DEPS_escaped), $(x)-makoi_build_depline) \
				$(foreach x, $(BASIC_DEPS_escaped), $(x)-makoi_build_basic_depline)
				$(foreach x, $(CHECK_ONLY_DEPS_escaped), $(x)-makoi_check_depline)

# The stem is a depline.
%-makoi_build_depline:: always
	$(MAKE) -C $(call dir_from_depline,$*) $(call targets_from_depline,$*)

# The stem is a depline.
%-makoi_build_basic_depline:: always
	@# Use standard make for basic deps instead of any mako wrappers.
	make -C $(call dir_from_depline,$*) $(call targets_from_depline, $*)

# The stem is a depline.
%-makoi_check_depline:: always
	$(MAKE) -C $(call dir_from_depline,$*) \
			$(foreach x, $(call targets_from_depline_expanded, $*), $(x)-makoi_check_target )

# The stem is a single target name.
# This is called by other mako processes to only check the given target, rather
# than build it.  BASIC_DEPS aren't checked because they presumably don't
# support it.  Instead, the target within the main stage will need to manually
# add prerequistes for any BASIC_DEPS.
%-makoi_check_target: $(MAKOI_EVENTS)/check \
		$(foreach x,$(DEPS_escaped),$(x)-makoi_check_depline) \
		$(foreach x,$(CHECK_ONLY_DEPS_escaped),$(x)-makoi_check_depline)
	MAKO_STAGE=main $(MAKE) --no-print-directory $(MAKOI_EVENTS)/check/$*

.PHONY: clean_deps
clean_deps: \
		$(foreach x, $(DEPS_escaped), $(x)-clean_dep ) \
		$(foreach x, $(CHECK_ONLY_DEPS_escaped), $(x)-clean_dep ) \
    $(foreach x, $(BASIC_DEPS_escaped), $(x)-clean_basic_dep )

# The stem is an escaped deps line.
%-clean_dep:: always
	$(MAKE) -C $(call dir_from_depline,$*) clean clean_deps

# The stem is an escaped deps line.
%-clean_basic_dep:: always
	make -C $(call dir_from_depline,$*) clean

$(MAKOI_EVENTS)/built $(MAKOI_EVENTS)/check:
	mkdir -p $@

endif # MAKO_STAGE

# Avoid problematic remake of this file and a calling Makefile if it's actually
# called "Makefile".
$(MAKO_ROOT)/base.mk:: ;
Mako.mk:: ;

