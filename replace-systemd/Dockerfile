FROM quay.io/fedora/fedora-coreos:stable
RUN rpm-ostree override replace https://bodhi.fedoraproject.org/updates/FEDORA-2022-0bbb402870 && \
    rpm-ostree cleanup -m && \
    ostree container commit
