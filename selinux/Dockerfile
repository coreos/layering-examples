# Change a SELinux boolean.  The first line is a workaround for a conflict
# between overlayfs semantics and libselinux that is on track to being fixed, see
# https://github.com/SELinuxProject/selinux/pull/342
FROM quay.io/fedora/fedora-coreos:stable
# See above; temporary work around; this should be fixed in newer libselinux.  Note
# that this `mv` incantation *must* be in the same RUN line (i.e. same layer) as
# the policy changes.
RUN mv /etc/selinux/targeted/active{,.tmp} && mv /etc/selinux/targeted/active{.tmp,} && \
    setsebool -P -N container_manage_cgroup 1
