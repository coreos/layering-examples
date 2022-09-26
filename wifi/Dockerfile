# Install wireless support along with a static configuration file.
FROM quay.io/coreos-assembler/fcos:testing-devel
RUN rpm-ostree install NetworkManager-wifi NetworkManager-wwan wpa_supplicant wireless-regdb && \
    ostree container commit
# And also inject a configuration
ADD ExampleCorpWifi.ini /etc/NetworkManager/system-connections/
