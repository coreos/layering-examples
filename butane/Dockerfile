# TODO: ship butane in an image in OCP
FROM registry.access.redhat.com/ubi8/ubi:latest as butane
# See the butane file for configuration changes
ADD demo.bu /demo.bu
RUN arch=$(arch); arch=${arch/x86_64/amd64}; curl -L https://mirror.openshift.com/pub/openshift-v4/${arch}/clients/butane/latest/butane-${arch} -o /usr/bin/butane && chmod a+x /usr/bin/butane
# Compile to ignition
RUN butane --pretty --strict demo.bu > /demo.ign

FROM registry.ci.openshift.org/rhcos-devel/rhel-coreos:4.11
# Copy our generated Ignition
COPY --from=butane /demo.ign demo.ign
# Now apply it to the live filesystem, and clean it up
RUN ignition-apply demo.ign && rm -f demo.ign && ostree container commit
