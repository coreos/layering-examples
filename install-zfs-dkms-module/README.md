# Install ZFS DKMS Kernel Module

This example installs the [ZFS](https://openzfs.org/) [DKMS](https://en.wikipedia.org/wiki/Dynamic_Kernel_Module_Support) kernel module.

This is useful because typically DKMS modules are built during system startup after a kernel has been updated. This doesn't work in `ostree` based distributions because DKMS attempts to install kernel modules into `/usr`, which on `ostree` based distributions is mounted read-only.

This example is not specific to ZFS and should be able to be applied to other DKMS modules.
