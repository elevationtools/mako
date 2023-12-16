
TESTS := diamond check_only container deps_download

.PHONY: test
test: $(foreach x, $(TESTS), $(x)-RUN_TEST)
	@echo
	@echo All tests succeeded

%-RUN_TEST::
	make -C $*


