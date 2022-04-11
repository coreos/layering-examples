# Example containers that derive from (Fedora) CoreOS

https://fedoraproject.org/wiki/Changes/OstreeNativeContainer
and https://github.com/coreos/enhancements/blob/main/os/coreos-layering.md

are aiming to make it native to Fedora (and derivatives)
to take a container build, but *boot* it and upgrade from it.

This repository contains example containers to demonstrate
functionality.

## Examples

- [inject-go-binary](inject-go-binary/): Demos adding building and injecting a Go binary + systemd unit
- [wifi](wifi/): Install support for wireless networks along with pre-baked configuration to join a network
- [tailscale](tailscale/): Demos https://tailscale.com/download/linux/fedora
