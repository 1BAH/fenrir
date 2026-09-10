VERSION      := 2026.1.3
BUILD_DIR    := /tmp/fenrir-build
INSTALL_DIR  := fenrir-$(VERSION)
INSTALL_ROOT := $(BUILD_DIR)/$(INSTALL_DIR)

BIN_DIR   := $(INSTALL_ROOT)/usr/bin
CONF_DIR  := $(INSTALL_ROOT)/etc/fenrir
SHARE_DIR := $(INSTALL_ROOT)/usr/share

export FENRIR_HOME := $(CONF_DIR)/fenrir_home

RPM_REPO_DIR := ~/1bah.github.io/rpm
DEB_REPO_DIR := ~/1bah.github.io/deb

default:

init: clean
	mkdir -p $(BIN_DIR) $(SHARE_DIR)/man $(SHARE_DIR)/doc/fenrir $(FENRIR_HOME)
	cp LICENSE $(SHARE_DIR)/doc/fenrir/

clean:
	rm -rf $(BUILD_DIR)

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

update-version:
	sed -E -i "s|^Version:.*$$|Version:        $(VERSION)|" fenrir.spec
	sed -E -i "s|^Version:.*$$|Version: $(VERSION)|" fenrir.control
	sed -E -i "s|^version:.*$$|version: $(VERSION)|" antora.yml
	sed -E -i "s|^version=.*$$|version=$(VERSION)|" src/main/fenrir/cli/fenrir.properties
	sed -E -i "s|^version=.*$$|version=\"$(VERSION)\"|" src/test/installTests.sh
	sed -E -i "s|^expected_version=.*$$|expected_version=\"$(VERSION)\"|" src/test/versionTests.sh
	sed -E -i "s|^The latest version is \`.*\`$$|The latest version is \`$(VERSION)\`|" README.adoc

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

update-repos: all
	cp ~/fenrir-1bah-$(VERSION).noarch.deb $(DEB_REPO_DIR)/pool/main/fenrir-1bah-$(VERSION)_all.deb
	cp ~/fenrir-$(VERSION).noarch.rpm $(RPM_REPO_DIR)/fenrir-$(VERSION).noarch.rpm
	@echo "Updating rpm repo index.."
	rpmsign --addsign $(RPM_REPO_DIR)/fenrir-$(VERSION).noarch.rpm
	createrepo_c --update $(RPM_REPO_DIR)
	gpg -ab --batch --yes $(RPM_REPO_DIR)/repodata/repomd.xml
	@echo "Updating apt repo index.."
	cd $(DEB_REPO_DIR) && apt-ftparchive --arch all packages pool/main > dists/stable/main/binary-all/Packages
	cd $(DEB_REPO_DIR) && gzip -9fk dists/stable/main/binary-all/Packages
	cd $(DEB_REPO_DIR) && apt-ftparchive -c release.conf release dists/stable > dists/stable/Release
	cd $(DEB_REPO_DIR) && gpg --yes --clearsign -o dists/stable/InRelease dists/stable/Release
	cd $(DEB_REPO_DIR) && gpg --yes -abs -o dists/stable/Release.gpg dists/stable/Release
