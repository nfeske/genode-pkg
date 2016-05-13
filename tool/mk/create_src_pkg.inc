#
# \brief  Common steps of creating API and source packages
# \author Norman Feske
# \date   2015-05-14
#
# The following variables must be defined before including this file:
#

#
# Look up recipe for assembling the package
#

RECIPE_DIR := $(wildcard $(EXPECTED_RECIPE_DIR))

ifeq ($(RECIPE_DIR),)
PKG :=
$(TARGET): recipe_missing
recipe_missing:
	@$(ECHO) "Error: Package recipe for '$(TARGET)' is missing,"
	@$(ECHO) "       expected directory at '$(EXPECTED_RECIPE_DIR)'"
	@false
endif


#
# Determine hash file of current package version as defined by the recipe
#

EXPECTED_RECIPE_HASH_FILE := $(RECIPE_DIR)/hash
RECIPE_HASH_FILE          := $(wildcard $(EXPECTED_RECIPE_HASH_FILE))

ifeq ($(RECIPE_HASH_FILE),)
PKG :=
$(TARGET): recipe_hash_file_missing
recipe_hash_file_missing:
	@$(ECHO) "Error: Package hash file missing,"
	@$(ECHO) "       expected at '$(EXPECTED_RECIPE_HASH_FILE)'"
	@false
endif


#
# Define name of temporary package directory that we use until we know the
# package hash
#

EXPORT_PKG_DIR := $(EXPORT_SUB_DIR)/$(TARGET).incomplete

ifneq ($(wildcard $(EXPORT_PKG_DIR)),)
PKG :=
$(TARGET): stale_temporary_pkg_dir
stale_temporary_pkg_dir:
	@$(ECHO) "Error: '$(EXPORT_PKG_DIR)' already exists"
	@false
endif


##
## Create package
##

#
# Rename package to the hashed name after successful completion
#
$(PKG): _rename_to_final_package

#
# Rename package name from the temporary name to the hashed name. However,
# if the hashed package name already exists, keep the existing one and
# dircard the just-built package.
#
_rename_to_final_package: _check_hash
	@$(VERBOSE)final_name=$(PKG)-$$(< $(EXPORT_PKG_DIR)/hash); \
	           test -e $(EXPORT_SUB_DIR)/$$final_name && \
	               ( rm -r $(EXPORT_PKG_DIR); \
	                 $(MSG_PREFIX)"keep existing package $$final_name" ); \
	           test -e $(EXPORT_PKG_DIR) && \
	               ( mv $(EXPORT_PKG_DIR) $(EXPORT_SUB_DIR)/$$final_name; \
	                 $(MSG_PREFIX)"created package $$final_name" ); \
	           true;

#
# Check the consistency between the hash of the package recipe and the actual
# hash of the generated package. If both hash values differ, we print the
# expected hash value and remove the package. The user is expected to
# update the recipe hash before attempting the package creation again.
#
_check_hash: $(EXPORT_PKG_DIR)/hash $(RECIPE_HASH_FILE)
	$(VERBOSE)diff $(EXPORT_PKG_DIR) $(RECIPE_HASH_FILE) > /dev/null ||\
		( hash=$$(< $(EXPORT_PKG_DIR)/hash); \
		  $(ECHO) "Warning: $(RECIPE_HASH_FILE) is out of date,\n" \
		          "         should contain" $$hash "\n" \
		          "\nYou may update the recipe hash via the following command:\n" \
		          "\n  echo" $$hash "> $(RECIPE_HASH_FILE)\n"; )

$(EXPORT_PKG_DIR)/hash: _check_license

#
# Check for the presence of licensing information. It is the job of the
# content.mk file to generate a LICENSE file.
#
_check_license: $(EXPORT_PKG_DIR)/include
	@$(VERBOSE)test -f $(EXPORT_PKG_DIR)/LICENSE ||\
		( $(ECHO) "Error: recipe at '$(RECIPE_DIR)' defines no LICENSE"; \
		  rm -r $(EXPORT_PKG_DIR); \
		  false )

#
# Generate the hash from the package content
#
# We use 'find *' instead of 'find .' to omit the leading './' prefix of the
# results of find.
#
$(EXPORT_PKG_DIR)/hash: $(EXPORT_PKG_DIR)/LICENSE
	@$(MSG_PREFIX)generate package hash
	$(VERBOSE)cd $(EXPORT_PKG_DIR); \
	          cat `find * -type f` | sort |  $(HASHSUM) | sed "s/ .*//" \
	          > hash

$(EXPORT_PKG_DIR):
	$(VERBOSE)mkdir -p $@

$(EXPORT_PKG_DIR)/LICENSE: $(EXPORT_PKG_DIR)

#
# Assemble package content by invoking the recipe's content.mk file
#
# If an error (such as a missing installation of a port) occurs during this
# step, remove the incomplete package before returning an error.
#
$(EXPORT_PKG_DIR)/LICENSE: $(RECIPE_DIR)/content.mk
	@$(MSG_PREFIX)assemble package content
	$(VERBOSE)make --quiet -f $(TOP_DIR)/tool/mk/content_env.mk \
	                       -C $(EXPORT_PKG_DIR) \
	                       CONTENT_MK=$< \
	                       GENODE_DIR=$(GENODE_DIR) \
	                       CONTRIB_DIR=$(GENODE_DIR)/contrib \
	                       VERBOSE=$(VERBOSE) || \
	( rm -r $(EXPORT_PKG_DIR); false )
