GO_EASY_ON_ME = 1
export SDKVERSION=8.1
export THEOS_DEVICE_IP=192.168.1.10

include theos/makefiles/common.mk

TWEAK_NAME = VKAdsRemover
VKAdsRemover_FILES = Tweak.xm
VKAdsRemover_FRAMEWORKS = UIKit
ARCHS = armv7 armv7s arm64

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 vkclient; killall -9 VkHdAppstore"
