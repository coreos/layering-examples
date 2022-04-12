# Example containers that derive from (Fedora) CoreOS

https://fedoraproject.org/wiki/Changes/OstreeNativeContainer
and https://github.com/coreos/enhancements/blob/main/os/coreos-layering.md

are aiming to make it native to Fedora (and derivatives)
to take a container build, but *boot* it and upgrade from it.

This repository contains example containers to demonstrate
functionality.

## Examples

- [inject-go-binary](inject-go-binary/): Demos adding building and injecting a Go binary + systemd unit
- [tailscale](tailscale/): Demos https://tailscale.com/download/linux/fedora
- [butane](butane/): Demos using https://github.com/coreos/butane

## Running an example

- Build an image using an example from this repo and push it to an image registry:
  ```
  set IMAGE (podman build $EXAMPLE -q)
  podman push $IMAGE quay.io/$USER/$EXAMPLE
  ```

- Setup a system that has `rpm-ostree` installed. One possibility is [using `virt-install`](https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/#_booting_on_a_local_hypervisor_libvirt_example).


- [Rebase the system](https://coreos.github.io/rpm-ostree/container/#rebasing-a-client-system) with `rpm-ostree` to the image
