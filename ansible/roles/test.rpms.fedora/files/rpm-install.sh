#!/bin/bash

set -ex

os_version=${OS_VERS:-"38"}
os_arch=${OS_ARCH:-"x86_64"}
samba_version=${SAMBA_VERS:-"master"}
rpms_dir="/tmp/testbuild/${samba_version}/fedora/${os_version}/${os_arch}"

dnf -y update --refresh

dnf -y install createrepo_c

pushd "${rpms_dir}"

createrepo_c .

popd

cat > "/etc/yum.repos.d/samba-${samba_version}-test-rpms.repo" <<EOF
[samba-${samba_version}-test-rpms]
name=Samba ${samba_version} test rpms repository
baseurl=file:///tmp/testbuild/${samba_version}/fedora/\$releasever/\$basearch
enabled=1
gpgcheck=0
EOF

# Since we do not have GlusterFS(master) and CephFS(main) packages built for
# Fedora, we make use of official released versions from standard Fedora
# repositories.

test_build_vers=$(dnf repoquery -q --disablerepo='*' \
			--enablerepo=samba-${samba_version}-test-rpms \
			--arch ${os_arch} --qf '%{version}-%{release}' samba)

pkgs=(samba-${test_build_vers} samba-test-${test_build_vers} \
	samba-vfs-glusterfs-${test_build_vers} samba-vfs-cephfs-${test_build_vers})

if [ "${os_version}" -ge 38 ]; then
	pkgs+=(samba-dc-${test_build_vers})
fi

dnf -y install ${pkgs[@]}
