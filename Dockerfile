# Build a small Go program
FROM registry.access.redhat.com/ubi8/ubi:latest as builder
WORKDIR /build
COPY . .
RUN yum -y install go-toolset
RUN go build hello-world.go

FROM registry.ci.openshift.org/coreos/walters-rhcos-ostreecontainer
# Inject our binary into the OS
COPY --from=builder /build/hello-world /usr/bin
# And add our unit file
ADD hello-world.service /etc/systemd/system/hello-world.service
# Also add irssi (my go-to example of strace is already in RHCOS)
# With some future work, we can make `yum install` work
RUN rpm -Uvh https://ftp.osuosl.org/pub/centos/8/AppStream/x86_64/os/Packages/irssi-1.1.1-3.el8.x86_64.rpm
