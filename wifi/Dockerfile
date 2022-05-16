# Install wireless support along with a static configuration file.
FROM registry.ci.openshift.org/rhcos-devel/rhel-coreos:4.11
#You will need the RHEL repos in a file.
ADD rhel.repo /etc/yum.repos.d
RUN rpm-ostree install NetworkManager-wifi NetworkManager-wwan wpa_supplicant wireless-regdb && \
    rpm-ostree cleanup -m && \
    ostree container commit
# And also inject a configuration
ADD ExampleCorpWifi.ini /etc/NetworkManager/system-connections/
