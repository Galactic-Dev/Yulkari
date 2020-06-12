ARCHS = arm64 arm64e
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = YulkariPrefs

YulkariPrefs_FILES = YLKRootListController.m
YulkariPrefs_INSTALL_PATH = /Library/PreferenceBundles
YulkariPrefs_FRAMEWORKS = UIKit
YulkariPrefs_PRIVATE_FRAMEWORKS = Preferences
YulkariPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/YulkariPrefs.plist$(ECHO_END)
