#!/usr/bin/env sh

# Variables in this file are configured from the .env file
# via the docker-compose.yml file and from the Dockerfile.
set -e

RADIUSDIR=/etc/raddb
CERTSDIR=${RADIUSDIR}/certs
SITESAVAILABLEDIR=${RADIUSDIR}/sites-available
SITESENABLEDDIR=${RADIUSDIR}/sites-enabled
BACKUPDIR=/backup
PROVISIONDIR=/provision
FRVERSION=$(radiusd -v | grep -o -m 1 "3.0.2[1-9]")
PATCHDIR=${SCRIPTDIR}/patches/${FRVERSION}
CHECKEAPTLS=${SITESAVAILABLEDIR}/check-eap-tls
DEFAULTSITE=${SITESAVAILABLEDIR}/default
EAPMOD=${RADIUSDIR}/mods-available/eap
FILTER=${RADIUSDIR}/policy.d/filter
RADIUSCONF=${RADIUSDIR}/radiusd.conf
CLIENTSCONF=${RADIUSDIR}/clients.conf
CACONFIG=${CERTSDIR}/ca.cnf
CAKEY=${CERTSDIR}/ca.key
CACERTPEM=${CERTSDIR}/ca.pem
CACRLPEM=${CERTSDIR}/wifi_ca_crl.pem
CACRL=${CERTSDIR}/wifi_ca.crl
CACERT=${CERTSDIR}/ca.der
CAPROVISION=${PROVISIONDIR}/ca.der
SRVCONFIG=${CERTSDIR}/server.cnf
CLIENTCONFIG=${CERTSDIR}/client.cnf
XPEXT=${CERTSDIR}/xpextensions
INITFINISHED=${CERTSDIR}/init_finished
EAPCONFIG=${RADIUSDIR}/mods-available/eap
CERTINDEX=${CERTSDIR}/index.txt
USERFILE=${RADIUSDIR}/mods-config/files/authorize
RADIUSSERVERFILE=${CERTSDIR}/RadiusServerName.txt
RSPROVISION=${PROVISIONDIR}/RadiusServerName.txt
# Calculate wildcard domain from host name of Radius server
# Example: if host name is radius.intra.lan the wild card domain is *.intra.lan
DOMAIN=$(printf '%s' "${RADIUS_HOST}" | sed -E "s/[^/.]*(\..*)/\1/")
WCD="*${DOMAIN}"

