content: include LICENSE lib src lib/mk/ld.mk mk

include:
	$(VERBOSE)cp -r $(GENODE_DIR)/repos/base/include $@
	$(VERBOSE)cp -r $(GENODE_DIR)/repos/base-sel4/include/base/native_types.h $@/base/

lib:
	$(VERBOSE)mkdir -p lib/mk
	$(VERBOSE)cp $(GENODE_DIR)/repos/base/lib/mk/ldso-startup.mk lib/mk/
	$(VERBOSE)touch lib/mk/platform.mk
	$(VERBOSE)touch lib/mk/base.mk
	$(VERBOSE)touch lib/mk/config.mk

lib/mk/ld.mk: lib
	$(VERBOSE) \
	( echo "SRC_SYMBOLS = symbols"; \
	  echo "vpath symbols \$$(REP_DIR)" ) > $@

mk:
	$(VERBOSE)mkdir -p $@
	$(VERBOSE)cp -r $(GENODE_DIR)/repos/base/mk/spec $@

src:
	$(VERBOSE)mkdir -p src/lib/ldso/startup
	$(VERBOSE)cp $(GENODE_DIR)/repos/base/src/lib/ldso/startup/startup.cc src/lib/ldso/startup/

LICENSE:
	$(VERBOSE)cp -r $(GENODE_DIR)/LICENSE $@

