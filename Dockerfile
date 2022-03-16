ARG RHEL_COREOS_IMAGE=registry.ci.openshift.org/rhcos-devel/rhel-coreos:4.11

# Build a small Go program
FROM registry.access.redhat.com/ubi8/ubi:latest as builder
WORKDIR /build
COPY . .
RUN yum -y install go-toolset
RUN go build hello-world.go

FROM $RHEL_COREOS_IMAGE
# Inject our binary into the OS
COPY --from=builder /build/hello-world /usr/bin
# And add our unit file
ADD hello-world.service /etc/systemd/system/hello-world.service
# Enable UBI
Add ubi.repo /etc/yum.repos.d
RUN rpm-ostree install pixman && rm -rf /var/cache