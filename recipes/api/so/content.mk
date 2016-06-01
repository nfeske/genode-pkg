content: lib/mk/ldso-startup.mk LICENSE

lib/mk/ldso-startup.mk:
	$(VERBOSE)mkdir -p $(dir $@)
	$(VERBOSE)cp $(GENODE_DIR)/repos/base/lib/mk/ldso-startup.mk $@

LICENSE:
	$(VERBOSE)cp $(GENODE_DIR)/LICENSE $@
