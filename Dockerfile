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
