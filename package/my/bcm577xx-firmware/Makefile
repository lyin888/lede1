#
# Copyright (C) 2015-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bcm577xx-firmware
PKG_VERSION:=1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=bcm577xx-firmware
	DEPENDS:=+kmod-libphy +kmod-phy-broadcom +kmod-tg3
	URL:=
endef

define Package/$(PKG_NAME)/description
  bcm577xx-firmware fw
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/modules-boot.d
	$(INSTALL_DATA) ./files/etc/modules-boot.d/18-phy-broadcom $(1)/etc/modules-boot.d/18-phy-broadcom
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
