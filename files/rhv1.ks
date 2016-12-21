# -------------------------------------------------------------------
# rhv1.ks - kickstart script for bootstrapped RHV hypervisor.
#
# This file is part of Field of Green's
# 
# Copyright (C) 2016 Anthony Green
# -------------------------------------------------------------------

install
text
reboot
lang en_US.UTF-8
keyboard us
timezone America/Toronto --isUtc

# -------------------------------------------------------------------
# Network.
# -------------------------------------------------------------------

network --bootproto static --ip=10.0.0.2 --gateway=10.0.0.1 --netmask=255.255.255.0 --nameserver=8.8.8.8 --hostname=rhv1.spindazzle.org --nodefroute --noipv6 

# -------------------------------------------------------------------
# Authentication.
# -------------------------------------------------------------------

# Generated with "openssl passwd -1 $PASSWORD"
rootpw --iscrypted $1$H.tLyuUR$gof4/7JqC04qcn26SXWyj1

# -------------------------------------------------------------------
# Services.
# -------------------------------------------------------------------

firewall --enabled
selinux --enforcing
firstboot --disable

# -------------------------------------------------------------------
# Disk partitioning.
# -------------------------------------------------------------------

zerombr
clearpart --all --initlabel
part /boot --fstype ext3 --size 128 
part / --fstype xfs --grow
part /home --fstype xfs --size 4096
part swap --recommended 
bootloader --location=mbr --append="rd_NO_PLYMOUTH"

# -------------------------------------------------------------------
# Packages list.
# -------------------------------------------------------------------

%packages
@base
ipa-client
%end

# -------------------------------------------------------------------
# Post script.
# -------------------------------------------------------------------

%post --log=/root/post_install_1.log

# Add 10.0.0.1 to /etc/hosts in order to speed up SSH connections
# during the bootstrap phase.  This host's SSH server will timeout on
# reverse DNS lookups otherwise.
cat >> /etc/hosts <<EOF
10.0.0.1  devbox.spindazzle.org
EOF

%end
