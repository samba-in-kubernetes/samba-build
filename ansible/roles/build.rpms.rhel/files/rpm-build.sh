#!/bin/bash

set -e

subscription-manager register --org "${ORG_ID}" --activationkey "${ACT_KEY}"

dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-${OS_VERS}.noarch.rpm

dnf -y install mock rpm-build

mock --root "${MOCK_DIR}/rhel-${OS_VERS}-x86_64.cfg" --resultdir "${RPMS_DIR}/${SAMBA_VERS}/rhel/${OS_VERS}/x86_64" --rebuild "${SRPM_DIR}/${SAMBA_SRPM}"

subscription-manager unregister
