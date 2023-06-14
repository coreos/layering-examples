# Example containers that derive from (Fedora) CoreOS

Fedora CoreOS is now also an OCI container image that can be used as a base
image to create *bootable* derivative containers.

See https://github.com/coreos/fedora-coreos-docs/pull/540 for more information about how to use this.

Additional background links are:

- https://fedoraproject.org/wiki/Changes/OstreeNativeContainer
- https://github.com/coreos/enhancements/blob/main/os/coreos-layering.md

This repository contains example containers to demonstrate
functionality.

## Examples

- [ansible-firewalld](ansible-firewalld/): Demos using [Ansible](https://github.com/ansible/ansible) to configure [firewalld](https://github.com/firewalld/firewalld)
- [build-zfs-module](build-zfs-module/): Build the ZFS third party module as rpm and install it
- [butane](butane/): Demos using https://github.com/coreos/butane
- [initramfs-module](initramfs-module/): Demos generating a initramfs with specific modules added and omitted.
- [inject-go-binary](inject-go-binary/): Demos adding building and injecting a Go binary + systemd unit
- [podman-next](podman-next): Use COPR to install the podman-next package
- [rsyslog](rsyslog/): Install and configure rsyslog to forward to a remote host
- [replace-kernel](replace-kernel): Replace the kernel using packages from Koji
- [replace-systemd](replace-systemd/): Replacing a base package, in this case systemd
- [selinux](selinux/): Demos changing a SELinux boolean
- [tailscale](tailscale/): Demos https://tailscale.com/download/linux/fedora
- [wifi](wifi/): Install support for wireless networks along with pre-baked configuration to join a network

## Running an example

- Build an image using an example from this repo and push it to an image registry:
  ```
  set IMAGE (podman build $EXAMPLE -q)
  podman push $IMAGE quay.io/$USER/$EXAMPLE
  ```

- Setup a system that has `rpm-ostree` installed. One possibility is [using `virt-install`](https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/#_booting_on_a_local_hypervisor_libvirt_example).


- [Rebase the system](https://coreos.github.io/rpm-ostree/container/#rebasing-a-client-system) with `rpm-ostree` to the image
