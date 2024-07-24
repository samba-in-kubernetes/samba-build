refspec = master
EXTRA_VARS := refspec=$(refspec)

ifneq ($(vers),)
	EXTRA_VARS += version=$(vers)
endif

prep.dirs:
	@ansible-playbook --inventory localhost, ./ansible/prep.dirs.yml

tarball:
	@ansible-playbook --inventory localhost, ./ansible/make.tarball.yml --extra-vars "refspec=$(refspec)"

srpm:
	@ansible-playbook --inventory localhost, ./ansible/build.srpm.yml --extra-vars "refspec=$(refspec)"


rpms.centos:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.centos.yml --extra-vars "$(EXTRA_VARS)"

test.rpms.centos:
	@ansible-playbook --inventory localhost, ./ansible/test.rpms.centos.yml --extra-vars "$(EXTRA_VARS)"


rpms.rhel:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.rhel.yml --extra-vars "$(EXTRA_VARS)"


rpms.fedora:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.fedora.yml --extra-vars "$(EXTRA_VARS)"

test.rpms.fedora:
	@ansible-playbook --inventory localhost, ./ansible/test.rpms.fedora.yml --extra-vars "$(EXTRA_VARS)"
