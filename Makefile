THEOS_DEVICE_IP = 192.168.2.6
ARCHS  = arm64 arm64e
TARGET = iphone:latest:9.0
ADDITIONAL_OBJCFLAGS = -fobjc-arc
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LookinLoader
LookinLoader_FILES = Tweak.xm
LookinLoader_FRAMEWORKS = UIKit
LookinLoader_CFLAGS = -fobjc-arc -Wdeprecated-declarations -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
