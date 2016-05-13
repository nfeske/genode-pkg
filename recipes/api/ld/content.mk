content: include LICENSE

include:
	$(VERBOSE)cp -r $(GENODE_DIR)/repos/base/include $@

LICENSE:
	$(VERBOSE)cp -r $(GENODE_DIR)/LICENSE $@

