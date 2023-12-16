
include $(MAKO_ROOT)/dep.mk

ifeq "$(MAKO_STAGE)" "main"

Linux-x86_64:
	download_and_extract tar.gz \
		'https://go.dev/dl/go1.21.5.linux-amd64.tar.gz'

Darwin-x86_64:
	download_and_extract tar.gz \
		'https://go.dev/dl/go1.21.5.darwin-amd64.tar.gz'

smoketest:
	go version | grep 'go1.21.5'

endif # MAKO_STAGE

