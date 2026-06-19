SYSTEMID := $(shell cat /etc/os-release | grep '^ID=' | cut -d'=' -f2)

PICS := $(wildcard lingmo/*.jpg lingmo/*.jpeg lingmo/*.png solidwallpapers/*.png)

# ifeq ($(USE_NONFREEPIC), 1)
# 	PICS := $(wildcard nonfree/deepin-private/*.jpg nonfree/unsplash.com/*.jpg $(PICS))
# endif

define md5sum
$(shell echo -n /usr/share/wallpapers/lingmo/$(1) | md5sum | awk '{print $$1}')s
endef

all: prepare $(addprefix blur/, ${PICS})

prepare: 
	@mkdir -p image-blur

blur/%: 
	/usr/lib/deepin-api/image-blur --sigma 30 $(subst blur/,,$@) image-blur/$(call md5sum,${@F}).jpg

clean:
	rm -rf image-blur
