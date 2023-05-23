#!/bin/bash

set -ex

os_version=${OS_VERS:-"8"}
samba_version=${SAMBA_VERS:-"master"}
rpms_dir="/tmp/testbuild/${samba_version}/centos/${os_version}/x86_64"

dnf -y update --refresh

dnf -y install epel-release

dnf -y install createrepo_c

pushd "${rpms_dir}"

createrepo_c .

popd

cat > "/etc/yum.repos.d/samba-${samba_version}-test-rpms.repo" <<EOF
[samba-${samba_version}-test-rpms]
name=Samba ${samba_version} test rpms repository
baseurl=file:///tmp/testbuild/${samba_version}/centos/\$releasever/\$basearch
enabled=1
gpgcheck=0
EOF

dnf -y install dnf-plugins-core

dnf config-manager \
	--add-repo http://artifacts.ci.centos.org/gluster/nightly/master.repo

dnf -y install --nogpgcheck \
	${CEPH_RELEASE_RPM_BASE_URL}/noarch/ceph-release-1-0.el${os_version}.noarch.rpm

test_build_vers=$(dnf repoquery -q --disablerepo='*' \
			--enablerepo=samba-${samba_version}-test-rpms \
			--arch x86_64 --qf '%{version}-%{release}' samba)

dnf_args=()

pkgs=(samba-${test_build_vers} samba-test-${test_build_vers} \
	samba-vfs-glusterfs-${test_build_vers} samba-vfs-cephfs-${test_build_vers})

if [ "${os_version}" == "9" ]; then
	dnf_args+=(--enablerepo=crb)
	pkgs+=(samba-dc-${test_build_vers})
fi

dnf ${dnf_args[@]} -y install ${pkgs[@]}
