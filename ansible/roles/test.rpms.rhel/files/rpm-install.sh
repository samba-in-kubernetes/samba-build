#!/bin/bash

set -e

os_version=${OS_VERS:-"8"}
samba_version=${SAMBA_VERS:-"master"}
rpms_dir="/tmp/testbuild/${samba_version}/rhel/${os_version}/x86_64"

subscription-manager register --org "${ORG_ID}" --activationkey "${ACT_KEY}"

dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-${os_version}.noarch.rpm

dnf -y install createrepo_c

pushd "${rpms_dir}"

createrepo_c .

popd

cat > "/etc/yum.repos.d/samba-${samba_version}-test-rpms.repo" <<EOF
[samba-${samba_version}-test-rpms]
name=Samba ${samba_version} test rpms repository
baseurl=file:///tmp/testbuild/${samba_version}/rhel/\$releasever/\$basearch
enabled=1
gpgcheck=0
EOF

dnf -y install --nogpgcheck \
	${CEPH_RELEASE_RPM_BASE_URL}/noarch/ceph-release-1-0.el${os_version}.noarch.rpm

test_build_vers=$(dnf repoquery -q --disablerepo='*' \
			--enablerepo=samba-${samba_version}-test-rpms \
			--arch x86_64 --qf '%{version}-%{release}' samba)

dnf -y --setopt epel.includepkgs=thrift install samba-${test_build_vers} \
	samba-test-${test_build_vers} samba-vfs-cephfs-${test_build_vers}

subscription-manager unregister
