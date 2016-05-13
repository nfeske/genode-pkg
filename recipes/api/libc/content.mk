content: include LICENSE lib

LIBPORTS_DIR := $(GENODE_DIR)/repos/libports

PORT_DIR := $(call port_dir,$(LIBPORTS_DIR)/ports/libc)

include:
	$(VERBOSE)mkdir $@
	$(VERBOSE)cp -r $(PORT_DIR)/include/* $@/
	$(VERBOSE)cp -r $(LIBPORTS_DIR)/include/libc-genode $@/

lib:
	$(VERBOSE)mkdir -p lib/import
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/import/import-libc.mk lib/import/

LICENSE:
	@(echo "Based on FreeBSD, which is BSD licensed:"; \
	  echo "  http://www.freebsd.org/copyright/freebsd-license.html"; \
	  echo "Genode-specific adaptations are GPL licensed:"; \
	  echo "  http://genode.org/about/licenses") > $@

