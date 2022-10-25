# Install and configure rsyslog
FROM quay.io/fedora/fedora-coreos:stable
RUN rpm-ostree install rsyslog && \
    rpm-ostree cleanup -m && \
    ostree container commit
ADD remote.conf /etc/rsyslog.d/remote.conf

