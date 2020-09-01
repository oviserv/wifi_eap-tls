FROM alpine:3

ARG TZ
ARG RADIUS_HOST

ENV SCRIPTDIR=/scripts TZ=${TZ} RADIUS_HOST=${RADIUS_HOST}

RUN apk upgrade --update && \
    apk add --no-cache freeradius freeradius-eap openssl make \
                       tzdata wpa_supplicant patch ca-certificates

COPY scripts ${SCRIPTDIR}
WORKDIR ${SCRIPTDIR}
RUN chmod 500 bootstrap.sh && ./bootstrap.sh

