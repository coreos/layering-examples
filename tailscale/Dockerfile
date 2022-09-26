# This is like https://tailscale.com/download/linux/fedora
# except it happens as part of a container build!  You then need to do
# `tailscale up` via some other mechanism.
FROM quay.io/coreos-assembler/fcos:testing-devel
RUN cd /etc/yum.repos.d/ && curl -LO https://pkgs.tailscale.com/stable/fedora/tailscale.repo && \
    rpm-ostree install tailscale && \
    systemctl enable tailscaled && \
    ostree container commit
