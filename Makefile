VERSION      := 2026.0+2
BUILD_DIR    := /tmp/fenrir-build
INSTALL_DIR  := fenrir-$(VERSION)
INSTALL_ROOT := $(BUILD_DIR)/$(INSTALL_DIR)

BIN_DIR   := $(INSTALL_ROOT)/usr/bin
CONF_DIR  := $(INSTALL_ROOT)/etc/fenrir
SHARE_DIR := $(INSTALL_ROOT)/usr/share

export FENRIR_HOME := $(CONF_DIR)/fenrir_home

default:

init: clean
	mkdir -p $(BIN_DIR) $(SHARE_DIR){/man,/doc/fenrir} $(FENRIR_HOME)
	cp LICENSE $(SHARE_DIR)/doc/fenrir/

clean:
	rm -r $(BUILD_DIR)

install-fenrir: init
	cd src/main/fenrir/cli && \
	./install-fenrir -t --install-dir $(BIN_DIR) --conf-dir $(CONF_DIR) --man-dir $(SHARE_DIR)/man

archive: install-fenrir
	rm $(BIN_DIR)/uninstall-fenrir
	cd $(BUILD_DIR) && tar cvzf fenrir-$(VERSION).tar.gz $(INSTALL_DIR)

rpm-clean:
	rm -fr ~/fenrir-$(VERSION).noarch.rpm ~/rpmbuild/SOURCES/fenrir-$(VERSION).tar.gz

deb-clean:
	rm -fr ~/fenrir-1bah-$(VERSION).noarch.deb

rpm: rpm-clean archive
	mkdir -p ~/rpmbuild/BUILD ~/rpmbuild/RPMS ~/rpmbuild/SOURCES ~/rpmbuild/SPECS ~/rpmbuild/SRPMS
	cp $(BUILD_DIR)/fenrir-$(VERSION).tar.gz ~/rpmbuild/SOURCES/
	cp fenrir.spec ~/rpmbuild/SPECS/
	cd ~/rpmbuild/SPECS/ && rpmbuild -ba fenrir.spec
	mv ~/rpmbuild/RPMS/noarch/fenrir-$(VERSION)* ~/fenrir-$(VERSION).noarch.rpm

deb: install-fenrir deb-clean
	cp -r $(INSTALL_ROOT) $(BUILD_DIR)/fenrir-deb
	mkdir -p $(BUILD_DIR)/fenrir-deb/DEBIAN
	cp fenrir.prerm    $(BUILD_DIR)/fenrir-deb/DEBIAN/prerm
	cp fenrir.control  $(BUILD_DIR)/fenrir-deb/DEBIAN/control
	cp fenrir.postinst $(BUILD_DIR)/fenrir-deb/DEBIAN/postinst
	chmod +x $(BUILD_DIR)/fenrir-deb/DEBIAN/prerm $(BUILD_DIR)/fenrir-deb/DEBIAN/postinst
	cd $(BUILD_DIR) && dpkg -b fenrir-deb
	mv $(BUILD_DIR)/fenrir-deb.deb ~/fenrir-1bah-$(VERSION).noarch.deb


all: rpm deb
