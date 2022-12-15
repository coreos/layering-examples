# Needs to be set to the Fedora version 
# on CoreOS stable stream, as it is our base image.
ARG BUILDER_VERSION=37

FROM quay.io/fedora/fedora-coreos:stable as kernel-query
#We can't use the `uname -r` as it will pick up the host kernel version
RUN rpm -qa kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}' > /kernel-version.txt

# Using https://openzfs.github.io/openzfs-docs/Developer%20Resources/Custom%20Packages.html
FROM registry.fedoraproject.org/fedora:${BUILDER_VERSION} as builder
ARG BUILDER_VERSION
COPY --from=kernel-query /kernel-version.txt /kernel-version.txt
WORKDIR /etc/yum.repos.d
RUN curl -L -O https://src.fedoraproject.org/rpms/fedora-repos/raw/f${BUILDER_VERSION}/f/fedora-updates-archive.repo && \
    sed -i 's/enabled=AUTO_VALUE/enabled=true/' fedora-updates-archive.repo
RUN dnf install -y jq dkms gcc make autoconf automake libtool rpm-build libtirpc-devel libblkid-devel \
    libuuid-devel libudev-devel openssl-devel zlib-devel libaio-devel libattr-devel elfutils-libelf-devel \
    kernel-$(cat /kernel-version.txt) kernel-modules-$(cat /kernel-version.txt) kernel-devel-$(cat /kernel-version.txt) \
    python3 python3-devel python3-setuptools python3-cffi libffi-devel git ncompress libcurl-devel
WORKDIR /
# Uses project_id from: https://release-monitoring.org/project/11706/
RUN curl "https://release-monitoring.org/api/v2/versions/?project_id=11706" | jq --raw-output '.stable_versions[0]' >> /zfs_version.txt
RUN curl -L -O https://github.com/openzfs/zfs/releases/download/zfs-$(cat /zfs_version.txt)/zfs-$(cat /zfs_version.txt).tar.gz && \
    tar xzf zfs-$(cat /zfs_version.txt).tar.gz && mv zfs-$(cat /zfs_version.txt) zfs
WORKDIR /zfs
RUN ./configure -with-linux=/usr/src/kernels/$(cat /kernel-version.txt)/ -with-linux-obj=/usr/src/kernels/$(cat /kernel-version.txt)/ \
    && make -j1 rpm-utils rpm-kmod

FROM quay.io/fedora/fedora-coreos:stable
COPY --from=builder /zfs/*.rpm /
# For the example we install all RPMS (debug, test, etc).
# In real use cases probably just want the module rpm.
RUN rpm-ostree install /*.$(uname -p).rpm && \
    # we don't want any files on /var
    rm -rf /var/lib/pcp && \
    ostree container commit 
