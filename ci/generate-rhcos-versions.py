#!/usr/bin/python3
# Update Dockerfiles to use rhcos images.

import os
import requests
import sys
import yaml

RHCOS_IMAGE = 'registry.ci.openshift.org/rhcos-devel/rhel-coreos:4.11'
RHEL_REPOS = '#You will need the RHEL repos in a file.\nADD rhel.repo /etc/yum.repos.d'
FCOS_IMAGE = 'quay.io/coreos-assembler/fcos:testing-devel'

basedir = os.path.normpath(os.path.join(os.path.dirname(sys.argv[0]), '..'))
for root, dirs, files in os.walk(basedir):
    for name in files:
        if not name.endswith("Dockerfile"):
            continue
        path = os.path.join(basedir, os.path.join(root, name))
        with open(path, "rt") as f:
            contents = f.read()
        replacement = RHCOS_IMAGE
        if contents.find('rpm-ostree install') >= 0:
            replacement = f"{replacement}\n{RHEL_REPOS}"
        print("Generating RHCOS version of:" + os.path.join(root, name))
        new_contents = contents.replace(FCOS_IMAGE, replacement)
        if contents == new_contents:
            print(f"No changes to {path}")
        else:
            with open(path, "wt") as f:
                f.write(new_contents)
