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
    for file in files:
        if file.endswith("Dockerfile"):
             print("Generating RHCOS version of:" + os.path.join(root, file))
             path = os.path.join(basedir, os.path.join(root, file))
             with open(path, "rt") as f:
                 content = f.read().replace(FCOS_IMAGE, RHCOS_IMAGE+'\n'+RHEL_REPOS)
             with open(path, "wt") as f:
                 f.write(content)
