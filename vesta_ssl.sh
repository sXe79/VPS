#!/bin/bash

#Setup
cert_src="/home/admin/conf/web/ssl.my-site.com.crt"
key_src="/home/admin/conf/web/ssl.my-site.com.key"
cert_dst="/usr/local/vesta/ssl/certificate.crt"
key_dst="/usr/local/vesta/ssl/certificate.key"

# Backup original certificates
if [ -f $cert_dst.bak_vesta_original ]
    then
        mv -f $cert_dst $cert_dst.bak
    else
        mv $cert_dst $cert_dst.bak_vesta_original
fi

if [ -f $key_dst.bak_vesta_original ]
    then
        mv -f $key_dst $key_dst.bak
    else
        mv $key_dst $key_dst.bak_vesta_original
fi

# Copy already verified certificates in Vesta SSL
cp -f $cert_src $cert_dst
cp -f $key_src $key_dst

# Edit User, Groups and permissions
chown root:mail $cert_dst
chown root:mail $key_dst
chmod 660 $cert_dst
chmod 660 $key_dst

# Restart services
service vesta restart
#service exim4 restart
#service dovecot restart
