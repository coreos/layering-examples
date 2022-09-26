# This example uses rpm-ostree's cliwrap to allow dracut to run on the container and generate an initramfs.
FROM quay.io/coreos-assembler/fcos:testing-devel
# Enable cliwrap.
RUN rpm-ostree cliwrap install-to-root /
# Replace the kernel, kernel-core and kernel-modules packages.
RUN rpm-ostree override replace https://kojipkgs.fedoraproject.org/packages/kernel/5.17.11/300.fc36/x86_64/kernel-modules-5.17.11-300.fc36.x86_64.rpm \
    https://kojipkgs.fedoraproject.org/packages/kernel/5.17.11/300.fc36/x86_64/kernel-core-5.17.11-300.fc36.x86_64.rpm \
    https://kojipkgs.fedoraproject.org/packages/kernel/5.17.11/300.fc36/x86_64/kernel-5.17.11-300.fc36.x86_64.rpm && \
    ostree container commit
