content: include LICENSE

LIBPORTS_DIR := $(GENODE_DIR)/repos/libports

PORT_DIR := $(call port_dir,$(LIBPORTS_DIR)/ports/zlib)

include:
	$(VERBOSE)mkdir $@
	$(VERBOSE)cp -r $(PORT_DIR)/include/zlib/* $@/

LICENSE:
	@echo "zlib license" > $@

