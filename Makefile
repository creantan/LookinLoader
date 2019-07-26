THEOS_DEVICE_IP = 192.168.2.6
ARCHS  = armv7s arm64
TARGET = iphone:latest:9.0
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LookinLoader
LookinLoader_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
