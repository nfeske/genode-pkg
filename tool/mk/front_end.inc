#
# 'TOP_DIR' must be define before including this file
#


TARGET := $(firstword $(sort $(MAKECMDGOALS)))
.PHONY: $(TARGET)

include $(TOP_DIR)/tool/mk/common.inc

RECIPES_DIR := $(TOP_DIR)/recipes

EXPORT_DIR := $(TOP_DIR)/export


#
# Determine GENODE_DIR
#

DEFAULT_GENODE_DIR := $(wildcard $(TOP_DIR)/genode)
GENODE_DIR         ?= $(DEFAULT_GENODE_DIR)

ifeq ($(GENODE_DIR),)
$(error GENODE_DIR is undefined)
endif

ifeq ($(wildcard $(GENODE_DIR)),)
$(error GENODE_DIR '$(GENODE_DIR)' does not exist)
endif

