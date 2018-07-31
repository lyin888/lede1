#
# Copyright (C) 2018 OpenWrt-dist
# Copyright (C) 2018 dz
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=wrtbwmon
PKG_VERSION:=0.6.1
PKG_REV:=472532c
PKG_RELEASE:=1

#PKG_SOURCE_PROTO:=git
#PKG_SOURCE_URL:=https://github.com/pyrovski/wrtbwmon.git
#PKG_SOURCE_VERSION:=$(PKG_REV)
#PKG_SOURCE_SUBDIR:=$(PKG_NAME)
#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_REV).tar.gz

#PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=ronggang

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=net
    CATEGORY:=Network
    TITLE:=wrtbwmon
    URL:=https://github.com/brvphoenix/luci-wrtbwmon
    DEPENDS:=
endef

define Package/$(PKG_NAME)/description
wrtbwmon was designed to track bandwidth consumption on home routers.
endef



define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) ./files/usr/sbin/wrtbwmon $(1)/usr/sbin/wrtbwmon
	$(CP) ./files/usr/sbin/readDB.awk $(1)/usr/sbin/readDB.awk
	$(INSTALL_DIR) $(1)/usr/share/wrtbwmon
	$(CP) ./files/usr/share/wrtbwmon/usage.htm1 $(1)/usr/share/wrtbwmon/usage.htm1
	$(CP) ./files/usr/share/wrtbwmon/usage.htm2 $(1)/usr/share/wrtbwmon/usage.htm2
	$(INSTALL_DIR) $(1)/etc/init.d
	$(CP) ./files/etc/init.d/wrtbwmon $(1)/etc/init.d/wrtbwmon
	
endef

#define Package/$(PKG_NAME)/install
#	$(INSTALL_DIR) $(1)/usr/sbin
#	$(CP) -r $(PKG_BUILD_DIR)/wrtbwmon $(1)/usr/sbin/wrtbwmon
#	$(CP) -r $(PKG_BUILD_DIR)/readDB.awk $(1)/usr/sbin/readDB.awk
#	$(INSTALL_DIR) $(1)/usr/share/wrtbwmon
#	$(CP) -r $(PKG_BUILD_DIR)/usage.htm1 $(1)/usr/share/wrtbwmon/usage.htm1
#	$(CP) -r $(PKG_BUILD_DIR)/usage.htm2 $(1)/usr/share/wrtbwmon/usage.htm2
#	$(INSTALL_DIR) $(1)/etc/init.d
#	$(CP) -r $(PKG_BUILD_DIR)/init/wrtbwmon $(1)/etc/init.d/wrtbwmon
#	
#endef



$(eval $(call BuildPackage,$(PKG_NAME)))
