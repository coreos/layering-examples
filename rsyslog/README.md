# Installing and configuring rsyslog

This example installs `rsyslog` *and* a [configuration file](remote.conf) for it.

This is a simple example, but it's worth elaborating here that we are *transactionally binding*
the configuration and code.  For example, if you want to update the `rsyslog` version *and*
change the config file at the same time, that is applied transactionally.
