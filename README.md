## About

Build debianized [Dante](https://www.inet.no/dante/index.html) SOCKS5 proxy server with [libpam-pwdfile](https://github.com/tiwe-de/libpam-pwdfile) (PAM module allowing authentication via an /etc/passwd-like file) support.

## Building

You need following packages installed:

1. `libpam0g-dev`, can be installed via `sudo apt install libpam0g-dev`.
1. `fpm`, for installation instructions see [GitHub](https://github.com/jordansissel/fpm).

To create deb package just run `make` command in the root of this repository.

## Usage

1. Install `libpam-pwdfile` package: `sudo apt install libpam-pwdfile`.
1. Install `whois` package (for `mkpasswd` utility): `sudo apt install whois`.
1. Add users to the `/etc/dante/pwdfile` file, format is `user:hash` per line. Use `mkpasswd -m sha-512` command to generate password's hash.
