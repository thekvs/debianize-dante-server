VERSION="1.4.2"
TMPDIR:=$(shell mktemp --directory --tmpdir dante.XXXXXXXXXX)
INSTALLDIR:=$(shell mktemp --directory --tmpdir dante.XXXXXXXXXX)
CPUS:=$(shell cat /proc/cpuinfo | grep processor | wc -l)

WORKDIR:=$(shell realpath .)

.PHONY: clean deb build check_env
.DEFAULT_GOAL := deb

clean:
	rm -f *.deb

check_env:
	if ! dpkg -s libpam0g-dev | grep Status | grep -q installed; then \
		echo ERROR: libpam0g-dev package is not installed!; \
		exit 1; \
	fi
	if ! which fpm; then \
		echo ERROR: fpm is not installed!; \
		exit 1; \
	fi

build: check_env
	cd $(TMPDIR) && \
		wget https://www.inet.no/dante/files/dante-$(VERSION).tar.gz && \
		tar xfz dante-$(VERSION).tar.gz && \
		cd dante-$(VERSION) && \
		./configure --prefix=$(INSTALLDIR)/usr --without-upnp --without-libwrap --without-ldap --without-krb5 --without-sasl && \
		make -j$(CPUS)&& \
		make install && \
		cp -a $(WORKDIR)/files/etc $(INSTALLDIR)

deb: build
	fpm -s dir -t deb -n "dante-server" \
		--version $(VERSION) \
		--description "SOCKS (v4 and v5) proxy daemon" \
		--deb-compression xz \
		--deb-systemd files/etc/systemd/system/dante.service \
		--maintainer "Konstantin Sorokin <kvs@sigterm.ru>" \
		--url https://www.inet.no/dante/index.html \
		--depends libpam-pwdfile \
		--depends libc6 \
		--depends libpam0g \
		-C $(INSTALLDIR)
	rm -rf $(TMPDIR)
	rm -rf $(INSTALLDIR)
