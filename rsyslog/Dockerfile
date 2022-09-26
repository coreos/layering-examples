# Install and configure rsyslog
FROM quay.io/coreos-assembler/fcos:testing-devel
RUN rpm-ostree install rsyslog && \
    ostree container commit
ADD remote.conf /etc/rsyslog.d/remote.conf

