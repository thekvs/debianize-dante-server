TMPDIR:=$(shell mktemp --directory --tmpdir dante.XXXXXXXXXX)
WORKDIR:=$(shell realpath .)

.PHONY: clean deb download
.DEFAULT_GOAL := deb

clean:
	rm -f *.deb
	rm -rf files/usr

download:
	cd $(TMPDIR) && \
		wget https://www.inet.no/dante/sslfiles/dante-1.4.2/tgz-prod.dante-1.4.2-rhel72-amd64-64bit-gcc.tar.gz && \
		tar xfz tgz-prod.dante-1.4.2-rhel72-amd64-64bit-gcc.tar.gz && \
		cp -a usr $(WORKDIR)/files/

deb: download
	fpm -s dir -t deb -n "dante-server" \
		--version 1.4.2 \
		--description "SOCKS (v4 and v5) proxy daemon" \
		--deb-compression xz \
		--deb-systemd files/etc/systemd/system/dante.service \
		--maintainer "Konstantin Sorokin <kvs@sigterm.ru>" \
		--depends libpam-pwdfile \
		--depends libc6 \
		--depends libpam0g \
		-C files
	rm -rf $(TMPDIR)
