FROM quay.io/coreos-assembler/fcos:testing-devel
RUN rpm-ostree override replace https://bodhi.fedoraproject.org/updates/FEDORA-2022-0bbb402870 && \
    ostree container commit
