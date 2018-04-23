## About

Build debianized [Dante](https://www.inet.no/dante/index.html) SOCKS proxy server with libpam-pwdfile (PAM module allowing authentication via an /etc/passwd-like file) support.

## Building

You need following packages installed:

1. `libpam0g-dev`, can be installed via `sudo apt install libpam0g-dev`.
1. `fpm`, for installation instructions see [GitHub](https://github.com/jordansissel/fpm/releases).

## Usage

To generate password hashes use `mkpasswd -m sha-512` command. `mkpasswd` is part of the `whois` package. You will also need `libpam-pwdfile` package.
