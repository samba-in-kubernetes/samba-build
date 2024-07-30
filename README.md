# Samba CentOS/Fedora RPM Builds

[![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora39-master&subject=master / Fedora 39>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-fedora39-master/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora39-v4-19-test&subject=v4-19-test / Fedora 39>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-fedora39-v4-19-test/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora39-v4-20-test&subject=v4-20-test / Fedora 39>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-fedora39-v4-20-test/)

[![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora40-master&subject=master / Fedora 40>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-fedora40-master/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora40-v4-19-test&subject=v4-19-test / Fedora 40>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-fedora40-v4-19-test/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora40-v4-20-test&subject=v4-20-test / Fedora 40>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-fedora40-v4-20-test/)

[![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos8-master&subject=master / CentOS 8>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-centos8-master/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos8-v4-19-test&subject=v4-19-test / CentOS 8>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-centos8-v4-19-test/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos8-v4-20-test&subject=v4-20-test / CentOS 8>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-centos8-v4-20-test/)

[![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos9-master&subject=master / CentOS 9>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-centos9-master/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos9-v4-19-test&subject=v4-19-test / CentOS 9>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-centos9-v4-19-test/) [![status](<https://jenkins-samba.apps.ocp.cloud.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos9-v4-20-test&subject=v4-20-test / CentOS 9>)](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/job/samba_build-rpms-centos9-v4-20-test/)

This repository contains automation to create [Samba](https://www.samba.org/)
RPMs for CentOS Stream 8/9, RHEL and Fedora from the upstream  [code repository](https://git.samba.org/samba.git).
In order to allow building from a variety of git refspecs, the following make
target format is used:

`$ make < rpms.centos | rpms.fedora | rpms.rhel > [ vers=< os-version > refspec=< branch-name | tag-name | h:<git-commit-hash> > ]`

A Few examples:

```console
$ make rpms.centos refspec=v4-20-test
$ make rpms.fedora vers=39 refspec=samba-4.19.6
$ make rpms.rhel refspec=h:a0862d6d6de
```

As of now, versions  4.19 and  4.20 and the master branch are supported. In the
absence of the *refspec* argument the master branch is built by default. The
above format is also applicable for other `make` targets. In the absence of
*vers* argument *9* and *40* will be the default for RHEL/CentOS and Fedora
respectively.

Except on CentOS Stream 8 and RHEL, in addition to vfs-glusterfs and vfs-cephfs,
Active Directory Domain Controller components are also built as RPMs.

These are automatically run as nightly jobs for CentOS Stream 8/9 and
Fedora 39/40 on [centos-ci](https://jenkins-samba.apps.ocp.cloud.ci.centos.org/view/RPM)
and published as [yum repositories](https://artifacts.ci.centos.org/samba/pkgs/).

### Building for RHEL
In order to match one-to-one with the dependencies from RHEL repositories we
have the following two options:

- Register the host running the build targets to ensure that mock has access to
mandatorily required RHEL repositories(BaseOS, AppStream and CodeReadyBuilder)
- If you want to leave the host as it is, use `ORG_ID` and `ACT_KEY` environment
variables to perform the build operation via podman containers where `ORG_ID` is
the organizational ID and `ACT_KEY` is the activation key name used for
registration purposes within container.