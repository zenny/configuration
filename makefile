# makefile --- main makefile for Göktuğ's configuration.

export VERSION!=date +'%Y%m%d%H%M'
export MAINT="Göktuğ Kayaalp <self@gkayaalp.com>"
export DEB=goktug.deb
HERE=$(PWD)

M4=m4 config.m4

all: help

### Help:
help:
	@echo "Targets:";\
	echo ;\
	echo "	invade		run invasion";\
	echo "	build		build utilites and emacs.d";\
	echo "			use \`bins' and \`emacs' rules to build these";\
	echo "			separately";\
	echo ;\
	echo "	deb		build the Debian package ($(DEB))";\
	echo "	deb-inst	install $(DEB), generating it if necessary";\
	echo ;\
	echo "	debian-config	install system configuration for Debian";\
	echo "	debian-init	initialise new Debian system";\
	echo ;\
	echo "	ubuntu-config	install system configuration for Ubuntu";\
	echo "	ubuntu-init	initialise new Ubuntu system";\
	echo ;\
	echo "	rpi-config	install system configuration for Raspbian/RPi";\
	echo "	rpi-init	initialise new Raspbian/RPi system";\
	echo ;\
	echo "	clean		delete build artefacts";\
	echo ;\
	echo "version: $(VERSION)";\
	echo

### Build rules:
build: bins emacs

bins:
	cd bin; $(MAKE) $(MAKEFLAGS); cd $(HERE)

emacs:
	cd emacs.d; $(MAKE) $(MAKEFLAGS) all; cd $(HERE)

clean-bin:
	rm -rf $(DEB); cd bin; $(MAKE) $(MAKEFLAGS) clean;\
	cd $(HERE)

invade:
	./bin/invade -v $(HOME)

### The Debian package:
deb: $(DEB)

$(DEB): deb-config deb/DEBIAN/control
	dpkg-deb -b deb $@

deb-config:
	cd deb/DEBIAN; $(MAKE) $(MAKEFLAGS); cd $(HERE)

deb-touch:
	touch deb/DEBIAN/control.in

deb-check:
	lintian $(DEB)

deb-inst: deb
	apt-get install --no-install-recommends ./$(DEB) && apt-get autoremove

clean-deb:
	rm -rf *.deb; cd deb/DEBIAN; $(MAKE) $(MAKEFLAGS) clean;\
	cd $(HERE)

### System configurations:
#### Debian/Ubuntu:
debian-init: deb-inst debian-config

DEBIANDIR=system/debian

$(DEBIANDIR)/etc/resolv.conf: $(DEBIANDIR)/etc/resolv.conf.in
	$(M4) $< > $@

$(DEBIANDIR)/etc/network/interfaces: $(DEBIANDIR)/etc/network/interfaces.in
	$(M4) $< > $@

DEBIANCONFFILS=$(DEBIANDIR)/etc/resolv.conf
DEBIANCONFFILS+=$(DEBIANDIR)/etc/network/interfaces

export GLOBIGNORE:=*.in

debian-config: $(DEBIANCONFFILS)
	cp -RPvu --preserve=mode --backup=numbered $(DEBIANDIR)/* /\

debian-regen:
	locale-gen && update-grub

ubuntu-init: deb-inst ubuntu-config

ubuntu-config:
	cp -RPvu --preserve=mode --backup=numbered system/ubuntu/* /

#### Raspberry Pi:
rpi-init: rpi-setup rpi-config

RPIDIR=system/rpi

$(RPIDIR)/etc/network/interfaces: $(RPIDIR)/etc/network/interfaces.in
	$(M4) $< > $@
$(RPIDIR)/etc/wpa_supplicant/wpa_supplicant.conf: $(RPIDIR)/etc/wpa_supplicant/wpa_supplicant.conf.in
	$(M4) $< > $@

RPICONFFILS=$(RPIDIR)/etc/network/interfaces
RPICONFFILS+=$(RPIDIR)/etc/wpa_supplicant/wpa_supplicant.conf

rpi-config: $(RPICONFFILS)
	cp -RPv --preserve=mode --backup=numbered $(RPIDIR)/* /

### Clean:
clean: clean-deb clean-bin clean-configs

clean-configs:
	rm -rf $(DEBIANCONFFILS) $(RPICONFFILS)

### Postamble:
.PHONY: all build bins deb deb-config deb-check deb-inst deb-touch
.PHONY: clean clean-bin clean-deb debian-config debian-init rpi-init
.PHONY: rpi-setup rpi-config rpi-config-files clean-configs

# Local variables:
# truncate-lines: t
# End:
