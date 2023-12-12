
define CHECK_ONLY_DEPS
	$(REPO_ROOT)/tests/container/app_code
endef

IMAGE_NAME := mako_tests/app_container
CONTEXT_DIR := $(REPO_ROOT)
DOCKER_BUILD_ARGS := --build-arg FOO=$(or $(FOO),default_in_container_mako)

include $(MAKO_ROOT)/container.mk

