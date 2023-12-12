
include $(MAKO_ROOT)/util.mk

ifeq "$(MAKO_STAGE)" "main"

DEFAULT_TARGETS := genfiles/api.pb.lang1 genfiles/api.pb.lang2
DEFAULT_PREREQS := api.proto

genfiles/api.pb.%:
	{ echo "--proto $*--"; cat api.proto; } > genfiles/api.pb.$*
	@# An easily corruptable operation if run in parallel.
	sleep 1
	echo slow write 1 >> genfiles/api.pb.$*
	sleep 1
	echo slow write 2 >> genfiles/api.pb.$*
	sleep 1
	echo slow write 3 >> genfiles/api.pb.$*

$(call mako_define_target, secondary, genfiles/secondary.pb.bin, secondary.proto)
genfiles/secondary.pb.bin: 
	{ echo "--bin--"; cat secondary.proto; } > $@

endif

include $(MAKO_ROOT)/component.mk

