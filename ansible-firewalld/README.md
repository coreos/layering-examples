# Running ansible in a container build for firewalling

In this example, we:

- Derive from the base image
- Install `ansible`
- Inject [a playbook](configure-firewall-playbook.yml) into the image
- Run ansible as part of the build, using the upstream `firewalld` task
- Remove `ansible` (we don't need it at runtime)

There's nothing really specific to firewalling here; this example can
be used as a reference for executing any arbitrary ansible playbook
as part of a container image build.