content: src/lib/zlib LICENSE lib/mk/zlib.mk

LIBPORTS_DIR := $(GENODE_DIR)/repos/libports

PORT_DIR := $(call port_dir,$(LIBPORTS_DIR)/ports/zlib)

src/lib/zlib:
	$(VERBOSE)mkdir -p $@
	$(VERBOSE)cp -r $(PORT_DIR)/src/lib/zlib/* $@

lib/mk/zlib.mk:
	$(VERBOSE)mkdir -p $(dir $@)
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/mk/zlib.mk $@

LICENSE:
	@echo "zlib license, see src/lib/zlib/README" > $@

