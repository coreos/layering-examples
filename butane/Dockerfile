# TODO https://github.com/coreos/butane/pull/338
FROM quay.io/coreos/butane as butane
# See the butane file for configuration changes
ADD demo.bu /demo.bu
# Compile to ignition
RUN butane --pretty --strict demo.bu > /demo.ign

FROM registry.ci.openshift.org/rhcos-devel/rhel-coreos:4.11
#You will need the RHEL repos in a file.
ADD rhel.repo /etc/yum.repos.d
# First workaround ignition-liveapply not being shipped yet.
RUN rpm -Uvh https://download.copr.fedorainfracloud.org/results/@CoreOS/continuous/fedora-35-x86_64/03938171-ignition/ignition-2.13.0.63.g919102e7-5.fc35.x86_64.rpm && \
    ln -sr /usr/lib/dracut/modules.d/30ignition/ignition /usr/bin/ignition-apply
# Copy our generated Ignition
COPY --from=butane /demo.ign demo.ign
# Now apply it to the live filesystem, and clean it up
RUN ignition-apply demo.ign && rm -f demo.ign && ostree container commit
