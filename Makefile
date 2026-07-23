VERSION      := 2026.0
BUILD_DIR    := /tmp/fenrir-build
INSTALL_DIR  := fenrir-$(VERSION)
INSTALL_ROOT := $(BUILD_DIR)/$(INSTALL_DIR)

default:

init:
	mkdir -p $(INSTALL_ROOT)/etc/fenrir $(INSTALL_ROOT)/usr/bin $(INSTALL_ROOT)/usr/share/man $(INSTALL_ROOT)/usr/share/doc/fenrir
	cp LICENSE $(INSTALL_ROOT)/usr/share/doc/fenrir/

clean:
	rm -r $(BUILD_DIR)

install-fenrir: init
	cd src/main/fenrir/cli && \
	./install-fenrir -t --install-dir $(INSTALL_ROOT)/usr/bin --conf-dir $(INSTALL_ROOT)/etc/fenrir --man-dir $(INSTALL_ROOT)/usr/share/man

archive: install-fenrir
	cd $(BUILD_DIR) && tar cvzf fenrir-$(VERSION).tar.gz $(INSTALL_DIR)

rpm: archive
	rpmdev-setuptree
	cp $(BUILD_DIR)/fenrir-$(VERSION).tar.gz ~/rpmbuild/SOURCES/
	cp fenrir.spec ~/rpmbuild/SPECS/
	cd ~/rpmbuild/SPECS/ && rpmbuild -ba fenrir.spec

deb: install-fenrir
	cp -r $(INSTALL_ROOT) $(BUILD_DIR)/fenrir-deb
	mkdir -p $(BUILD_DIR)/fenrir-deb/DEBIAN
	cp fenrir.control $(BUILD_DIR)/fenrir-deb/DEBIAN/control
	cd $(BUILD_DIR) && dpkg -b fenrir-deb
	mv $(BUILD_DIR)/fenrir-deb.deb $(BUILD_DIR)/fenrir-$(VERSION).noarch.deb

all: rpm deb
