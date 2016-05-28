content: include src LICENSE lib

LIBPORTS_DIR := $(GENODE_DIR)/repos/libports

PORT_DIR := $(call port_dir,$(LIBPORTS_DIR)/ports/libc)

OS_INCLUDES := \
	block_session \
	file_system \
	file_system_session \
	input \
	input_session \
	nic \
	nic_session \
	os \
	packet_stream_rx \
	packet_stream_tx \
	ram_fs \
	report_session \
	rtc_session \
	terminal \
	terminal_session \
	timer_session \
	util \
	vfs

include:
	$(VERBOSE)mkdir $@
	$(VERBOSE)cp -r $(LIBPORTS_DIR)/include/libc-plugin include/
	$(VERBOSE)cp -r $(addprefix $(GENODE_DIR)/repos/os/include/,$(OS_INCLUDES)) include/

src:
	$(VERBOSE)mkdir $@
	$(VERBOSE)cp -r $(PORT_DIR)/src/* src/
	$(VERBOSE)cp -r $(LIBPORTS_DIR)/src/lib/libc/* src/lib/libc/
	$(VERBOSE)mkdir -p src/lib/vfs
	$(VERBOSE)cp $(GENODE_DIR)/repos/os/src/lib/vfs/file_system_factory.cc src/lib/vfs/

lib:
	$(VERBOSE)mkdir -p lib/mk
	$(VERBOSE)mkdir -p lib/mk/spec/arm
	$(VERBOSE)mkdir -p lib/mk/spec/x86_32
	$(VERBOSE)mkdir -p lib/mk/spec/x86_64
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/mk/libc-*  lib/mk
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/mk/libc.mk lib/mk
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/mk/spec/arm/libc.mk           lib/mk/spec/arm/
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/mk/spec/x86_32/libc.mk        lib/mk/spec/x86_32/
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/mk/spec/x86_64/libc.mk        lib/mk/spec/x86_64/
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/mk/spec/arm/libc-gen.mk       lib/mk/spec/arm/
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/mk/spec/x86_32/libc-gen.mk    lib/mk/spec/x86_32/
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/mk/spec/x86_64/libc-gen.mk    lib/mk/spec/x86_64/
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/mk/spec/arm/libc-setjmp.mk    lib/mk/spec/arm/
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/mk/spec/x86_32/libc-setjmp.mk lib/mk/spec/x86_32/
	$(VERBOSE)cp $(LIBPORTS_DIR)/lib/mk/spec/x86_64/libc-setjmp.mk lib/mk/spec/x86_64/
	$(VERBOSE)cp $(GENODE_DIR)/repos/os/lib/mk/vfs.mk lib/mk

LICENSE:
	@(echo "Based on FreeBSD, which is BSD licensed:"; \
	  echo "  http://www.freebsd.org/copyright/freebsd-license.html"; \
	  echo "Genode-specific parts are GPL licensed:"; \
	  echo "  http://genode.org/about/licenses") > $@

