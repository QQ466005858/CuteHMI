first: all

include ../Makefile.include

include Makefile.include

include ../libiconv/Makefile.include
include ../gettext/Makefile.include

PRODUCT_NAME = zlib
PRODUCT_VERSION = 1.2.11
PRODUCT_DIRNAME = $(PRODUCT_NAME)-$(PRODUCT_VERSION)
PRODUCT_PORT_SUFFIX = $(TARGET_MACHINE)

PRODUCT_ARCHIVE = $(PRODUCT_NAME)-$(PRODUCT_VERSION).tar.gz
PRODUCT_ARCHIVE_URL = https://zlib.net/$(PRODUCT_ARCHIVE)
PRODUCT_ARCHIVE_DIR = $(ARCHIVE_DIR)
PRODUCT_ARCHIVE_PATH = $(PRODUCT_ARCHIVE_DIR)/$(PRODUCT_ARCHIVE)

PRODUCT_SOURCE_DIR = $(SOURCE_DIR)/$(PRODUCT_DIRNAME)

PRODUCT_PORT_DIR = $(PORT_DIR)/$(PRODUCT_DIRNAME)-$(PRODUCT_PORT_SUFFIX)

PRODUCT_BUILD_DIR = $(BUILD_DIR)/$(PRODUCT_DIRNAME)-$(PRODUCT_PORT_SUFFIX)

PRODUCT_INSTALL_DIR = $(ZLIB_INSTALL_DIR)
PRODUCT_INSTALL_INCLUDE_DIR = $(PRODUCT_INSTALL_DIR)/include
PRODUCT_INSTALL_LIB_DIR = $(PRODUCT_INSTALL_DIR)/bin

PRODUCT_DEPLOY_DIR = $(ZLIB_DEPLOY_DIR)
PRODUCT_DEPLOY_INCLUDE_DIR = $(PRODUCT_DEPLOY_DIR)/include
PRODUCT_DEPLOY_LIB_DIR = $(PRODUCT_DEPLOY_DIR)/lib

PRODUCT_CONFIGURE_TXT_PATH = $(BUILD_DIR)/$(PRODUCT_NAME)-$(PRODUCT_VERSION)-$(PRODUCT_PORT_SUFFIX).configure.txt 
PRODUCT_README_PORT_MD_PATH = $(PRODUCT_PORT_DIR)/README.$(PRODUCT_PORT_SUFFIX).md
PRODUCT_BUILD_TXT_PATH = $(BUILD_DIR)/$(PRODUCT_NAME)-$(PRODUCT_VERSION)-$(PRODUCT_PORT_SUFFIX).build.txt

PRODUCT_INCLUDE_FILES = zconf.h zlib.h
PRODUCT_INCLUDE_FILES_INSTALL = $(addprefix $(PRODUCT_INSTALL_INCLUDE_DIR)/, $(PRODUCT_INCLUDE_FILES))
PRODUCT_INCLUDE_FILES_DEPLOY = $(addprefix $(PRODUCT_DEPLOY_INCLUDE_DIR)/, $(PRODUCT_INCLUDE_FILES))

PRODUCT_LIB_FILES = zlib1.dll
PRODUCT_LIB_FILES_INSTALL = $(addprefix $(PRODUCT_INSTALL_LIB_DIR)/, $(PRODUCT_LIB_FILES))
PRODUCT_LIB_FILES_DEPLOY = $(addprefix $(PRODUCT_DEPLOY_LIB_DIR)/, $(PRODUCT_LIB_FILES))
 
PATH := $(GETTEXT_INSTALL_DIR)/bin:$(LIBICONV_INSTALL_DIR)/bin:$(PATH)

export PATH MAKE

include ../Makefile.phony

all: deploy

include ../Makefile.deploy

buildinstall $(PRODUCT_LIB_FILES_INSTALL) $(PRODUCT_INCLUDE_FILES_INSTALL): $(PRODUCT_BUILD_TXT_PATH) | $(CD) $(MAKE) $(TOUCH)
	$(CD) $(PRODUCT_BUILD_DIR) && $(MAKE) -j $(MAKE_BUILD_JOBS) -f win32/Makefile.gcc install \
		BINARY_PATH=$(PRODUCT_INSTALL_DIR)/bin \
		LIBRARY_PATH=$(PRODUCT_INSTALL_DIR)/lib \
		INCLUDE_PATH=$(PRODUCT_INSTALL_DIR)/include \
		SHARED_MODE=1
	$(TOUCH) $(PRODUCT_INCLUDE_FILES_INSTALL)
	$(TOUCH) $(PRODUCT_LIB_FILES_INSTALL)

build $(PRODUCT_BUILD_TXT_PATH): $(PRODUCT_BUILD_DIR)/win32/Makefile.gcc | $(CD) $(MAKE) $(TEE) $(CMD)
	$(CD) $(PRODUCT_BUILD_DIR) && $(MAKE) -j $(MAKE_BUILD_JOBS) CFLAGS+='-g0' -f win32/Makefile.gcc \
		BINARY_PATH=$(PRODUCT_INSTALL_DIR)/bin \
		LIBRARY_PATH=$(PRODUCT_INSTALL_DIR)/lib \
		INCLUDE_PATH=$(PRODUCT_INSTALL_DIR)/include \
		SHARED_MODE=1 \
		2>&1 | $(TEE) $(PRODUCT_BUILD_TXT_PATH)

buildconfigure $(PRODUCT_BUILD_DIR)/win32/Makefile.gcc: $(PRODUCT_BUILD_DIR)/configure | $(CD) $(SH) $(TEE) $(AWK) $(CMD) $(TOUCH)
	$(CD) $(PRODUCT_BUILD_DIR) && $(SH) configure 2>&1 | $(TEE) $(PRODUCT_CONFIGURE_TXT_PATH)
	$(TOUCH) $(PRODUCT_BUILD_DIR)/win32/Makefile.gcc

include ../Makefile.builddir

include ../Makefile.port

include ../Makefile.portdir

include ../Makefile.sourcedir

include ../Makefile.archive

include ../Makefile.clean

