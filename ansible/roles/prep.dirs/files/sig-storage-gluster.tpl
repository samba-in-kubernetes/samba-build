config_opts['yum.conf'] += """

[centos-gluster11]
name=CentOS-$releasever-stream - Gluster 11
metalink=https://mirrors.centos.org/metalink?repo=centos-storage-sig-gluster-11-$releasever-stream&arch=$basearch
#baseurl=http://mirror.stream.centos.org/SIGs/$releasever-stream/storage/$basearch/gluster-11/
gpgcheck=0
enabled=1
"""
