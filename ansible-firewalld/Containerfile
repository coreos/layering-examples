# This example uses Ansible to configure firewalld to set up a node-local firewall suitable as recommended for use as an OpenShift 4 worker.
# However, this is intended to generalize to using Ansible as well as firewalld for generic tasks.
FROM quay.io/fedora/fedora-coreos:stable

ADD configure-firewall-playbook.yml .

# Install firewalld; also install ansible, use it to run a playbook, then remove it
# so it doesn't take up space persistently.
# TODO: Need to also remove ansible-installed dependencies
RUN rpm-ostree install firewalld ansible && \
    ansible-playbook configure-firewall-playbook.yml && \
    rpm -e ansible && \
    rpm-ostree cleanup -m && \
    ostree container commit
