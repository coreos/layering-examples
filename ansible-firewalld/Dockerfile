# This example uses Ansible to configure firewalld to set up a node-local firewall suitable as recommended for use as an OpenShift 4 worker.
# However, this is intended to generalize to using Ansible as well as firewalld for generic tasks.
FROM quay.io/coreos-assembler/fcos:testing-devel

# Install firewalld and ansible
RUN rpm-ostree install firewalld ansible

ADD configure-firewall-playbook.yml .

# Run playbook setting ports.
RUN ansible-playbook -vvv configure-firewall-playbook.yml

#TO-DO remove ansible when supported by rpm-ostree in container.
