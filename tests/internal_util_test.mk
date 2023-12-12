
include ./internal_util.mk

test_eq = @test "$(1)" = "$(2)" && echo "  OK" || { \
	echo "  Failure: '$(1)' != '$(2)'"; exit 1; }

.DEFAULT_GOAL := all

all: \
		escape_deps_test \
		unescape_depline_test \
		dir_from_depline_test \
		targets_from_depline_test \
		targets_from_depline_expanded_test \
		expand_deps_to_prereqs_test

# Fixture used in multiple tests.
define dep_list
 /some/repo
/another/repo one two
 /last/repo one
endef

dep_list_escaped := /some/repo /another/repo+one+two /last/repo+one
escape_deps_test:
	@echo escape_deps_test
	$(call test_eq,$(call escape_deps,$(dep_list)),$(dep_list_escaped))

unescape_depline_test:
	@echo unescape_depline_test
	$(call test_eq,$(call unescape_depline,/some/repo+foo+bar),/some/repo foo bar)

dir_from_depline_test:
	@echo dir_from_depline_test
	$(call test_eq,$(call dir_from_depline,/some/repo+foo+bar),/some/repo)

zero_deps := $(call targets_from_depline,/some/repo/dir)
one_dep := $(call targets_from_depline,/some/repo/dir+one)
two_deps := $(call targets_from_depline,/some/repo/dir+one+two)
targets_from_depline_test:
	@echo targets_from_depline_test
	$(call test_eq,$(zero_deps),)
	$(call test_eq,$(one_dep),one)
	$(call test_eq,$(two_deps),one two)

zero_deps_exp := $(call targets_from_depline_expanded,/some/repo/dir)
one_dep_exp := $(call targets_from_depline_expanded,/some/repo/dir+one)
two_deps_exp := $(call targets_from_depline_expanded,/some/repo/dir+one+two)
targets_from_depline_expanded_test:
	@echo targets_from_depline_expanded_test
	$(call test_eq,$(zero_deps_exp),core)
	$(call test_eq,$(one_dep_exp),one)
	$(call test_eq,$(two_deps_exp),one two)

prereq_list := $(sort $(strip \
	/some/repo/genfiles/mako/check/core \
	/another/repo/genfiles/mako/check/one \
	/another/repo/genfiles/mako/check/two \
	/last/repo/genfiles/mako/check/one ))
expand_deps_to_prereqs_test:
	@echo expand_deps_to_prereqs_test
	$(call test_eq,$(call expand_deps_to_prereqs,$(dep_list)),$(prereq_list))

