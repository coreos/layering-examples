# This is like https://tailscale.com/download/linux/fedora
# except it happens as part of a container build!  You then need to do
# `tailscale up` via some other mechanism.
FROM registry.ci.openshift.org/rhcos-devel/rhel-coreos:4.11
RUN cd /etc/yum.repos.d/ && curl -LO https://pkgs.tailscale.com/stable/centos/8/tailscale.repo && \
    rpm-ostree install tailscale && rm -rf /var/cache/rpm-ostree && \
    systemctl enable tailscaled && \
    ostree container commit
