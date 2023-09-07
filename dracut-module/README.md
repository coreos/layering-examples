# Install and run a dracut module

This example adds a dracut module to the container and calls dracut to build a new initrd using this module.

This is useful when something needs to run inside of the initrd, which is very early in the boot process.

This specific example registers a systemd service that prints out when it was executed.
