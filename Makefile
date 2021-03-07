GO_EASY_ON_ME = 1
PREFIX=$(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/
export TARGET = iphone:clang:13.4

export ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Yulkari

Yulkari_FILES = Tweak.x
Yulkari_CFLAGS = -fobjc-arc
Yulkari_FRAMEWORKS = SafariServices

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += yulkariprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
