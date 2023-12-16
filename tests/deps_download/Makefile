
export PATH := $(CURDIR)/deps/bin:$(PATH)

.PHONY: test
test: jsonnet-download_dep golang-download_dep

.PHONY: clean
clean: jsonnet-clean_dep golang-clean_dep

%-download_dep::
	$(MAKE) -C deps/$* smoketest

%-clean_dep:
	$(MAKE) -C deps/$* clean

