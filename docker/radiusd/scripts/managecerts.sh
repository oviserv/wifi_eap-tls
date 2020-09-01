#!/usr/bin/env sh

# Adjust standard configuration files of FreeRadius for creation of a Certificate Authority (CA).
# Restore latest backup file if available
# This script assumes that de configuration files are not altered in any way.
# Security settings are quite relaxed.
# Evaluate the risks if they are acceptable for your use case.
# Settings are partly based on https://wiki.alpinelinux.org/wiki/FreeRadius_EAP-TLS_configuration
# See README in certs dir of FreeRadius installation for more information

source ${SCRIPTDIR}/config.sh
source ${SCRIPTDIR}/sharedfunctions.sh

# Start initialization
set -e

# Set umask for created files
umask 0027

set_lifetime() {
# Parameters: crt_lifetime($1), crl_lifetime($2), file($3)
    set_value default_days ${1} ${3}
    set_value default_crl_days ${2} ${3}
}

set_password() {
# Parameters: password($1), file($2)
    set_value input_password ${1} ${2}
    set_value output_password ${1} ${2}
}

get_password() {
# Parameters: file($1)
    /bin/sed -En "s/output_password[[:space:]]*=[[:space:]]*([[:xdigit:]]*)/\1/p" ${1}
}

set_password_in_eap_config() {
# Parameters: password($1)
    set_value private_key_password ${1} ${EAPCONFIG}
}

set_generic_attributes() {
# Parameters: sectionname($1), file($2), email($3)
    EMAIL=${4:-freeradius@localhost}
    set_value_in_section $1 countryName ${COUNTRYNAME} ${2}
    set_value_in_section $1 localityName ${LOCALITYNAME} ${2}
    set_value_in_section $1 organizationName FreeRadiusUser ${2}
    set_value_in_section $1 emailAddress ${EMAIL} ${2}
}

configure_uri_crl() {
    # Configure URI for CRL
    # According to Freeradius documentation this CRL should exist
    # This can be combined with this Radius server
    # $1 is name of config file

    set_value crlDistributionPoints "URI:http:\/\/${RADIUS_HOST}\/wifi_ca.crl" ${1}
}
# Check if init is necessary
if [ -f "${INITFINISHED}" ]; then
    /usr/bin/printf "Initialization already performed. Nothing to do.\n"
    exit 0
fi

# Check for latest backup file
BACKUPFILE=$(/bin/ls ${BACKUPDIR}/*_backup.tar.gz|/usr/bin/sort -r|/usr/bin/head -1)
if [ -f "${BACKUPFILE}" ]; then
    # Restore backup: only certs dir, clients and authorize files are restored
    # All config files are available in tar!
    # Restore manually if necessary
    /bin/tar -C / -xzvf ${BACKUPFILE} etc/raddb/certs/ \
                                      etc/raddb/clients.conf \
                                      etc/raddb/mods-config/files/authorize 
    PWDSRV=$(get_password ${SRVCONFIG})
    set_password_in_eap_config ${PWDSRV}
    exit 0
fi

# Go to working certificate directory
cd ${CERTSDIR}

# Make DH parameters
/usr/bin/make dh

# Configure the Certificate Authority.
set_lifetime ${CA_LIFETIME} ${CRL_LIFETIME} ${CACONFIG}

# Configure URI for CRL
# According to Freeradius documentation this CRL should exist
# This can be combined with this Radius server
#set_value crlDistributionPoints "URI:http:\/\/${RADIUS_HOST}\/wifi_ca.crl" ${CACONFIG}
configure_uri_crl ${CACONFIG}

# Set Certificate Authority password
# The password for the private key of the CA should be stored safely!
# The password is stored on the filesystem, only readable for root.
# For installations with higher security demands, the password should be stored offline.
# When generating user certificates, this password is needed.
CAPASSWORD=$(password)
set_password ${CAPASSWORD} ${CACONFIG}

# Set CA attributes
# Add a datecode to commonName to make it possible to distinguish multiple CA's
set_value_in_section certificate_authority commonName "\"Wifi Certificate Authority ${DATECODE}\"" ${CACONFIG}
set_generic_attributes certificate_authority ${CACONFIG}

# Generate CA
/usr/bin/make ca.pem
/usr/bin/make ca.der
/bin/chmod 400 ca.key
/bin/cp ${CACERT} ${PROVISIONDIR}
/bin/chmod 444 /${PROVISIONDIR}/ca.der
# Remove execute from bootstrap script to prevent running by accident
/bin/chmod 444 bootstrap
generate_crl ${CAPASSWORD}


# Configure the lifetime of the server certificate
set_lifetime ${CA_LIFETIME} ${CRL_LIFETIME} ${SRVCONFIG}

# Configure the server certificate
PWDSRV=$(password)
set_password ${PWDSRV} ${SRVCONFIG}
set_password_in_eap_config ${PWDSRV}
set_generic_attributes server ${SRVCONFIG}
set_value_in_section server commonName "\"Radius server ${DATECODE}\"" ${SRVCONFIG}
set_value DNS.1 ${RADIUS_HOST} ${SRVCONFIG}
/bin/sed -Ei "s/(otherName.0[[:space:]]*=[[:print:]]*UTF8:)([[:print:]]*)/\1${WCD}/" ${SRVCONFIG}
configure_uri_crl ${XPEXT}

# Generate server certificate
/usr/bin/make server.pem

# Configure general values for client certificates
set_lifetime ${CA_LIFETIME} ${CRL_LIFETIME} ${CLIENTCONFIG}
set_generic_attributes client ${CLIENTCONFIG} user@example.org

# Configure authorize (users) file
# Start with an empty file containing one empty line
/bin/echo "" > ${USERFILE}

# Signal that init finished succesfully
/bin/touch ${INITFINISHED}
