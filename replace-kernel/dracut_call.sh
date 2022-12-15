#!/bin/bash
# Temporary workaround for: https://github.com/coreos/rpm-ostree/issues/4190
# This has been fixed on rpm-ostree 2022.18 and this script will be removed
# once that version reaches the stable coreos stream.
version=$(rpm-ostree --version | grep Version)
if [[ "$version" == *"2023"* ]] || [[ "$version" == *"2022.18"* ]]; then
    echo "Running rpm-ostree 2022.18 or newer.";
else
    echo "Running rpm-ostree 2022.17 or older, rebuilding the initramfs.";
    kver=$(ls /lib/modules)
    echo "Building initramfs for Kernel: $kver" 
    /usr/libexec/rpm-ostree/wrapped/dracut --tmpdir /tmp/ --no-hostonly --kver $kver --reproducible \
    -v --add ostree -f /tmp/initramfs2.img
    mv /tmp/initramfs2.img /lib/modules/$kver/initramfs.img
fi;

