# Use the default kernel version if the Makefile doesn't override it

LINUX_RELEASE?=1

LINUX_VERSION-3.18 = .123
LINUX_VERSION-4.4 = .153
LINUX_VERSION-4.9 = .120
LINUX_VERSION-4.14 = .63

LINUX_KERNEL_HASH-3.18.123 = c10de32c9b31fb619b016a00d77afc394db5a4542e258e927f06a5ead86f8c64
LINUX_KERNEL_HASH-4.4.153 = 0f2355515c22ca705600043bedc75218c68dcb8ab528f57f67851fbcb8545402
LINUX_KERNEL_HASH-4.9.120 = d75af506865edc8145a344c4e73c3bb1000e6c9f1c3489b8dae47ca8f033fd91
LINUX_KERNEL_HASH-4.14.63 = cd2e52f0e7ba861afa91cf487b2f45e5174115870f256a1d65996647b7bcc6d3

remove_uri_prefix=$(subst git://,,$(subst http://,,$(subst https://,,$(1))))
sanitize_uri=$(call qstrip,$(subst @,_,$(subst :,_,$(subst .,_,$(subst -,_,$(subst /,_,$(1)))))))

ifneq ($(call qstrip,$(CONFIG_KERNEL_GIT_CLONE_URI)),)
  LINUX_VERSION:=$(call sanitize_uri,$(call remove_uri_prefix,$(CONFIG_KERNEL_GIT_CLONE_URI)))
  ifeq ($(call qstrip,$(CONFIG_KERNEL_GIT_REF)),)
    CONFIG_KERNEL_GIT_REF:=HEAD
  endif
  LINUX_VERSION:=$(LINUX_VERSION)-$(call sanitize_uri,$(CONFIG_KERNEL_GIT_REF))
else
ifdef KERNEL_PATCHVER
  LINUX_VERSION:=$(KERNEL_PATCHVER)$(strip $(LINUX_VERSION-$(KERNEL_PATCHVER)))
endif
endif

split_version=$(subst ., ,$(1))
merge_version=$(subst $(space),.,$(1))
KERNEL_BASE=$(firstword $(subst -, ,$(LINUX_VERSION)))
KERNEL=$(call merge_version,$(wordlist 1,2,$(call split_version,$(KERNEL_BASE))))
KERNEL_PATCHVER ?= $(KERNEL)

# disable the md5sum check for unknown kernel versions
LINUX_KERNEL_HASH:=$(LINUX_KERNEL_HASH-$(strip $(LINUX_VERSION)))
LINUX_KERNEL_HASH?=x
