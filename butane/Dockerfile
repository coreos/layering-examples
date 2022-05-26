# TODO https://github.com/coreos/butane/pull/338
FROM quay.io/coreos/butane as butane
# See the butane file for configuration changes
ADD demo.bu /demo.bu
# Compile to ignition
RUN butane --pretty --strict demo.bu > /demo.ign

FROM quay.io/coreos-assembler/fcos:testing-devel
# Copy our generated Ignition
COPY --from=butane /demo.ign demo.ign
# Now apply it to the live filesystem, and clean it up
RUN /usr/libexec/ignition-apply demo.ign && rm -f demo.ign && ostree container commit
