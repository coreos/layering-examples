# Change a SELinux boolean.  The FROM line is using the `next` tag
# as workaround for a conflict between overlayfs semantics and 
# libselinux. This issue is already fixed on the `next` CoreOS 
# stream but has not reached the stable CoreOS stream.
# https://github.com/SELinuxProject/selinux/pull/342
FROM quay.io/fedora/fedora-coreos:next

RUN setsebool -P -N container_manage_cgroup 1
