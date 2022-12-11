FROM alpine:3.16

ARG TZ
ARG RADIUS_HOST
ARG APKREPO_EDGE
ARG NO_PREPARE

ENV SCRIPTDIR=/scripts TZ=${TZ} RADIUS_HOST=${RADIUS_HOST} \
    NO_PREPARE=${NO_PREPARE}

RUN apk add --no-cache ${APKREPO_EDGE} freeradius \
                                       freeradius-eap \
                                       freeradius-utils && \
    apk add --no-cache openssl make ca-certificates \
                       tzdata patch wpa_supplicant

COPY scripts ${SCRIPTDIR}
WORKDIR ${SCRIPTDIR}
RUN chmod 500 bootstrap.sh && ./bootstrap.sh

