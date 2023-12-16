
include $(MAKO_ROOT)/dep.mk

ifeq "$(MAKO_STAGE)" "main"

Linux-x86_64:
	download_and_extract tar.gz \
		'https://github.com/google/go-jsonnet/releases/download/v0.20.0/go-jsonnet_0.20.0_Linux_x86_64.tar.gz'

Darwin-x86_64:
	download_and_extract tar.gz \
		'https://github.com/google/go-jsonnet/releases/download/v0.20.0/go-jsonnet_0.20.0_Darwin_x86_64.tar.gz'

smoketest:
	jsonnet --version | grep '(Go implementation) v0.20.0'

endif # MAKO_STAGE

