# Build a small Go program
FROM registry.access.redhat.com/ubi8/ubi:latest as builder
WORKDIR /build
COPY . .
RUN yum -y install go-toolset
RUN go build hello-world.go

FROM quay.io/cgwalters/fcos-dev
# Inject it into Fedora CoreOS
COPY --from=builder /build/hello-world /usr/bin
# And add our unit file
ADD hello-world.service /etc/systemd/system/hello-world.service
# Also add strace; we don't yet support `yum install` but we can
# with some work in rpm-ostree!
RUN rpm -Uvh https://kojipkgs.fedoraproject.org//packages/strace/5.14/1.fc34/x86_64/strace-5.14-1.fc34.x86_64.rpm
