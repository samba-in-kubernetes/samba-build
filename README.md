# Samba CentOS/Fedora RPM Builds

[![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora37-master&subject=master / Fedora 37>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-fedora37-master/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora37-v4-18-test&subject=v4-18-test / Fedora 37>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-fedora37-v4-18-test/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora37-v4-17-test&subject=v4-17-test / Fedora 37>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-fedora37-v4-17-test/)

[![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora38-master&subject=master / Fedora 38>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-fedora38-master/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora38-v4-18-test&subject=v4-18-test / Fedora 38>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-fedora38-v4-18-test/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora38-v4-17-test&subject=v4-17-test / Fedora 38>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-fedora38-v4-17-test/)

[![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos8-master&subject=master / CentOS 8>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-centos8-master/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos8-v4-18-test&subject=v4-18-test / CentOS 8>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-centos8-v4-18-test/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos8-v4-17-test&subject=v4-17-test / CentOS 8>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-centos8-v4-17-test/)

[![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos9-master&subject=master / CentOS 9>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-centos9-master/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos9-v4-18-test&subject=v4-18-test / CentOS 9>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-centos9-v4-18-test/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos9-v4-17-test&subject=v4-17-test / CentOS 9>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-centos9-v4-17-test/)

This repository contains automation to create RPMs for CentOS Stream 8/9 and
Fedora from Samba repository. In order to allow building from a variety of git
refspecs, the following make target format is used:

`$ make < rpms.centos8 | rpms.centos9 | rpms.fedora > [ vers=< fedora-version > refspec=< branch-name | tag-name | h:<git-commit-hash> > ]`

Few examples:

- `$ make rpms.centos8 refspec=v4-16-test`
- `$ make rpms.centos9 refspec=h:a0862d6d6de`
- `$ make rpms.fedora vers=37 refspec=samba-4.16.4`

As of now 4.17, 4.18 and master branches are supported. In the absence of
*refspec* argument, the master branch is built by default. The above format is
also applicable for other `make` targets. The *vers* argument is only valid for
Fedora related make targets and in its absence, the default version is
set to *38*.

Except on CentOS Stream 8, in addition to vfs-glusterfs and vfs-cephfs, Active
Directory Domain Controller components are also built as RPMs.

These are automatically run as nightly jobs for CentOS Stream 8/9 and
Fedora 37/38 on [centos-ci](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/view/RPMs)
and published as [yum repositories](https://artifacts.ci.centos.org/samba/pkgs/).
