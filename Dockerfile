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
ADD RPM-GPG-KEY-centosofficial /etc/pki/rpm-gpg/
ADD centos.repo /etc/yum.repos.d
RUN rpm-ostree install irssi && rm -rf /var/cache 
