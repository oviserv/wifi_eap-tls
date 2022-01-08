#!/usr/bin/env sh

set -e
. config.sh

# Exit if environment variable NO_PREPARE is set
[ -n "${NO_PREPARE}" ] && echo "NO_PREPARE is set, cancelling bootstrap" && \
	exit 0

chmod 500 managecerts.sh backup.sh manageusers.sh 
chown root:radius start.sh config.sh sharedfunctions.sh && chmod 550 start.sh config.sh sharedfunctions.sh

# Save default config files for later reference
/bin/cp -a "${RADIUSDIR}" /root/ 

# Patch configuration files
[ ! -d "${PATCHDIR}" ] &&
  echo "FreeRadius version ${FRVERSION} is not supported" && exit 1

/usr/bin/patch -b "${RADIUSCONF}" < "${PATCHDIR}/radiusd.conf.patch"
/usr/bin/patch -b "${CHECKEAPTLS}" < "${PATCHDIR}/check-eap-tls.patch"
/usr/bin/patch -b "${DEFAULTSITE}" < "${PATCHDIR}/default.patch"
/usr/bin/patch -b "${EAPMOD}" < "${PATCHDIR}/eap.patch"
# -b option not added to prevent double loading of filter
# Store copy under root
/bin/cp "${FILTER}" /root/filter.orig
/usr/bin/patch "${FILTER}" < "${PATCHDIR}/filter.patch"
# Start with empty clients.conf
/bin/mv "${CLIENTSCONF}" "${CLIENTSCONF}.orig"
/bin/touch "${CLIENTSCONF}"
/bin/chmod 640 "${CLIENTSCONF}"
/bin/chown root:radius "${CLIENTSCONF}"

# Enable check-eap-tls
cd "${SITESENABLEDDIR}"
ln -s "${CHECKEAPTLS}" .

# Remove unnecessary links
/bin/rm /etc/raddb/sites-enabled/inner-tunnel
/bin/rm /etc/raddb/mods-enabled/chap
/bin/rm /etc/raddb/mods-enabled/mschap
/bin/rm /etc/raddb/mods-enabled/ntlm_auth
/bin/rm /etc/raddb/mods-enabled/passwd
/bin/rm /etc/raddb/mods-enabled/pap
/bin/rm /etc/raddb/mods-enabled/digest
