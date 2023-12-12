
include $(MAKO_ROOT)/util.mk

#### Interface ####

IMAGE_NAME ?= $(error required)
CONTEXT_DIR ?= $(error required)
IMAGE_BUILD_PREREQS ?= $(wildcard Dockerfile*)
DOCKER_BUILD_ARGS ?=
DEBUG_DOCKERFILE ?= false

#### End Interface ####


DEFAULT_TARGETS := genfiles/image_built
DEFAULT_PREREQS := $(IMAGE_BUILD_PREREQS)

ifeq "$(MAKO_STAGE)" "main"

ifeq "$(DEBUG_DOCKERFILE)" "true"
DOCKER_BUILD_ARGS += --progress=plain
endif

genfiles/image_built:
	docker image build $(DOCKER_BUILD_ARGS) -t $(IMAGE_NAME) \
		-f ./Dockerfile $(CONTEXT_DIR)
	touch $@

endif # main

include $(MAKO_ROOT)/component.mk

# Avoid the problematic auto-remake of this file.
$(MAKO_ROOT)/container.mk:: ;

