# This is like https://tailscale.com/download/linux/fedora
# except it happens as part of a container build!  You then need to do
# `tailscale up` via some other mechanism.
FROM registry.ci.openshift.org/rhcos-devel/rhel-coreos:4.11
#You will need the RHEL repos in a file.
ADD rhel.repo /etc/yum.repos.d
RUN cd /etc/yum.repos.d/ && curl -LO https://pkgs.tailscale.com/stable/fedora/tailscale.repo && \
    rpm-ostree install tailscale && rpm-ostree cleanup -m && \
    systemctl enable tailscaled && \
    ostree container commit
