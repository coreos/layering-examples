# inject-go-binary

This example demonstrates using a standard `Dockerfile`
multi-stage build to compile a Go binary from source
along with a systemd unit, and inject it into the
target operating system.

Additionally, `strace` is installed as a layered
package.
