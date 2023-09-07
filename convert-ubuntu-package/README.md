# Convert an Ubuntu Package and Install It

This example converts an Ubuntu package into an rpm using [alien](https://wiki.debian.org/Alien) and then installs it using `rpm-ostree`.

This is useful for packages that are present in Ubuntu, but not in Fedora. This example installs Ubuntu's latest packaged version of gocryptfs, which is [no longer maintained in Fedora](https://discussion.fedoraproject.org/t/gocryptfs-not-available-on-fedora-36).
