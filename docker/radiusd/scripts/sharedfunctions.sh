#!/usr/bin/env sh

password() {
# Generate 128 bits password
    /usr/bin/openssl rand -hex 32
}

set_value() {
# Parameters: valuename ($1) value($2), file($3)
    /bin/sed -Ei "s/(${1}[[:space:]]*=)([[:space:]][[:print:]]*)/\1 ${2}/" "${3}"
}

set_value_in_section() {
# Parameters: sectionname ($1) valuename ($2) value($3), file($4)
    /bin/sed -Ei "/\[[[:space:]]*${1}[[:space:]]*\]/,/${2}/{s/(${2}[[:space:]]*=)([[:space:]][[:print:]]*)/\1 ${3}/}" "${4}"
}

generate_crl() {
# Generate new CRL (combined with CA certificate)
# Parameters: password_ca ($1)
    /usr/bin/openssl ca -gencrl -keyfile "${CAKEY}" -cert "${CACERTPEM}" -config "${CACONFIG}" -out "${CACRLPEM}" -key "${1}"
    /usr/bin/openssl crl -in "${CACRLPEM}" -outform der -out "${CACRL}"
    cat "${CACERTPEM}" >> "${CACRLPEM}"
}

copy_generic_to_provision() {
# Copy the CA certificate and the text file with the Radius server name
# to the provision directory as they are needed to configure clients
    if [ ! -f "${CAPROVISION}" ]
    then
        /bin/cp "${CACERT}" "${CAPROVISION}"
        /bin/chmod 444 "${CAPROVISION}"
    fi

    # Reconstruct file with Radius server name for configs generated
    # with older vesions
    if [ -f "${RADIUSSERVERFILE}" ]
    then
       /bin/grep "Radius server" "${SRVCONFIG}" | \
         /usr/bin/awk -F '"' '{print $2}' > "${RADIUSSERVERFILE}"
    fi

    if [ ! -f "${RSPROVISION}" ]
    then
        /bin/cp "${RADIUSSERVERFILE}" "${RSPROVISION}"
        /bin/chmod 444 "${RSPROVISION}"
    fi
}
