# Install wireless support along with a static configuration file.
FROM quay.io/fedora/fedora-coreos:stable
RUN rpm-ostree install NetworkManager-wifi NetworkManager-wwan wpa_supplicant wireless-regdb && \
    rpm-ostree cleanup -m && \
    ostree container commit
# And also inject a configuration
ADD ExampleCorpWifi.ini /etc/NetworkManager/system-connections/
