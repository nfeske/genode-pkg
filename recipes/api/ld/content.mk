content: include LICENSE mk lib

include:
	$(VERBOSE)cp -r $(GENODE_DIR)/repos/base/include $@
	$(VERBOSE)cp -r $(GENODE_DIR)/repos/base-sel4/include/base/native_types.h $@/base/

lib:
	$(VERBOSE)mkdir -p lib/mk
	$(VERBOSE)touch lib/mk/base.mk
	$(VERBOSE)touch lib/mk/config.mk

mk:
	$(VERBOSE)mkdir -p $@
	$(VERBOSE)cp -r $(GENODE_DIR)/repos/base/mk/spec $@

LICENSE:
	$(VERBOSE)cp $(GENODE_DIR)/LICENSE $@

