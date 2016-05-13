#
# \brief  Common environment
# \author Norman Feske
# \date   2014-05-27
#

SHELL   := bash
VERBOSE ?= @
ECHO    := echo -e
HASHSUM := sha1sum

MAKEFLAGS += --no-print-directory

BRIGHT_COL  ?= \x1b[01;33m
DARK_COL    ?= \x1b[00;33m
DEFAULT_COL ?= \x1b[0m

MSG_PREFIX_TXT := $(DARK_COL)$(TARGET)  $(DEFAULT_COL)
MSG_PREFIX     := $(ECHO) "$(MSG_PREFIX_TXT)"

