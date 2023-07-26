# Loading Kernel Module

### Get the correct kernel-version

We need the correct kernel version in order to build the kernel-module for the
right kernel.

Since after reboot, the kernel of the host will be the kernel RPM installed on
the new image, aka, the `fedora-coreos:stable` image that we are using as
the last layer, then the correct way to get the kernel version is by getting it
from the image itself.
```
$ podman run -it fedora-coreos:stable rpm -qa | grep kernel
kernel-modules-core-6.3.8-200.fc38.x86_64
kernel-core-6.3.8-200.fc38.x86_64
kernel-modules-6.3.8-200.fc38.x86_64
kernel-6.3.8-200.fc38.x86_64
```

Let's export the kernel version.
```
export KERNEL_VERSION=6.3.8-200.fc38.x86_64
```

### Build the container image

Now, we will build a simple container image that will contains a basic
kernel-module in it.

Since the kernel we want to build is a `fc38` kernel we will use `fedora:38` as
a base image to build the kernel-module.

```
podman build --build-arg KERNEL_VERSION=${KERNEL_VERSION} -t quay.io/ybettan/fedora-coreos:kmm-kmod -f Containerfile
podman push quay.io/ybettan/fedora-coreos:kmm-kmod
```

### Create an ignition file

Ignition files are a way to configure a CoreOS machine at boot time.

We are going to create a simple ignition file that add your public SSH key to
the machine so you can SSH to it after the installation.

Edit `fcos-config.fcc` and put your public SSH key in it. Then we are going to
generate the ignition file from that yaml.

```
podman run -i --rm quay.io/coreos/fcct -p -s <fcos-config.fcc > fcos-config.ign
```

And make sure it was created correctly by inspecting `fcos-config.ign`.

### Configuring SELinux

We are goign to use `virt` in order to install the VM, therefore, we need to
add a SELinux rule to allow `virt` to read the ignition file.

If you don't want to add any SELInux rule you can temporarly disable it.

* Check SELinux status: `getenforce`
* Disable SELinux: `setenforce 0` (status should become `permissive`)
* Enable SELinux: `setenforce 1` (status should become `enforcing`)

### Provision a Fedora-CoreOS VM

Now, we are going to download the Fedora-CoreOS disk image for Qemu. We
are going to use that disk in order to boot a VM from it later on this
tutorial.

The version of Fedora we are using for this VM doesn't really matter to much as we
are going to reboot from the contianer we built anyway.

For instuctions on how to create the VM visit
[provisioning-libvirt](https://docs.fedoraproject.org/en-US/fedora-coreos/provisioning-libvirt/)

We can run `virsh console fcos` to get a boot console.

### SSH to the machine

Use `virsh net-dhcp-leases default` in order to get the VM IP and then we can SSH to it.

```
ssh core@<ip>
```

### Rebooting from the container

From inside the VM we will use the `rpm-ostree rebase` command in order to
reboot from a spacific container image.

```
sudo su
rpm-ostree rebase --experimental ostree-unverified-registry:quay.io/ybettan/fedora-coreos:kmm-kmod --bypass-driver
systemctl reboot
```

### SSH to the new FedoraCoreOS image

Once the VM has booted, we can SSH to it again and validate that we indeed have
the "new layer" of the image.

```
[core@localhost ~]$ rpm-ostree status
State: idle
Deployments:
● ostree-unverified-registry:quay.io/ybettan/fedora-coreos:kmm-kmod
                   Digest: sha256:5d1f14548bc202c7051d8f67ab524c5745ad3c9b16149685de25b791abee066a
                  Version: 38.20230625.3.0 (2023-07-16T09:14:56Z)

  fedora:fedora/x86_64/coreos/stable
                  Version: 38.20230625.3.0 (2023-07-11T11:57:53Z)
                   Commit: e841d77aadb875bb801ac845a0d9b8a70b4224bdeb15e7d6c5bff1da932c0301
             GPGSignature: Valid signature by 6A51BBABBA3D5467B6171221809A8D7CEB10B464
```

We can also validate that the kernel-module is present
```
[core@localhost ~]$ lsmod | grep kmm_ci_a
kmm_ci_a               16384  0
```
