#!/bin/bash
# Backup original certificates
mv /usr/local/vesta/ssl/certificate.crt /usr/local/vesta/ssl/certificate.crt.bak
mv /usr/local/vesta/ssl/certificate.crt /usr/local/vesta/ssl/certificate.key.bak
# Copy already verified certificates in Vesta SSL
cp /home/admin/conf/web/ssl.my-site.com.crt /usr/local/vesta/ssl/certificate.crt
cp /home/admin/conf/web/ssl.my-site.com.key /usr/local/vesta/ssl/certificate.key
# Edit User, Groups and permissions
chown root:mail /usr/local/vesta/ssl/certificate.crt
chown root:mail /usr/local/vesta/ssl/certificate.key
chmod 660 /usr/local/vesta/ssl/certificate.crt
chmod 660 /usr/local/vesta/ssl/certificate.key
# Restart services
service vesta restart
#service exim4 restart
#service dovecot restart

# Cron
# TODO - Verify

# This solution use simlinks
# https://medium.com/andrewmmc-io/apply-ssl-certificate-by-lets-encrypt-to-vestacp-b2e255e93496

# Backup original certificates
mv /usr/local/vesta/ssl/certificate.crt /usr/local/vesta/ssl/certificate.crt.bak
mv /usr/local/vesta/ssl/certificate.crt /usr/local/vesta/ssl/certificate.key.bak

cert_src="/home/admin/conf/web/ssl.my-site.com.crt"
key_src="/home/admin/conf/web/ssl.my-site.com.key"
cert_dst="/usr/local/vesta/ssl/certificate.crt"
key_dst="/usr/local/vesta/ssl/certificate.key"

if ! cmp -s $cert_dst $cert_src
    then
        # Copy Certificate
        cp $cert_src $cert_dst

        # Copy Keyfile
        cp $key_src $key_dst

        # Change Permission
        chown root:mail $cert_dst
        chown root:mail $key_dst

        # Restart Services
        service vesta restart &> /dev/null
        service exim4 restart &> /dev/null
        service dovecot restart &> /dev/null
    fi