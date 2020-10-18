# Linux EAP-TLS Wifi installation
This document describes the necessary steps to connect a Linux machine to a Wifi network protected with EAP-TLS
To start with you need the CA certificate (ca.der), key/certificate pair (in a *.p12 file) and the accompanying password generated with the manageusers.sh in your FreeRadius installation.

## General installation
On Linux (and other OS's like FreeBSD) wpa_supplicant is used to connect a host to a Wifi network. In the examples section of wpa_supplicant the `wpa2-eap-ccmp.conf` configuration file should be used to get started.

# Ubuntu 20.04 server
On an Ubuntu 20.04 server the connection to a Wifi network protected with EAP-TLS was tested using netplan.

## Install certificates and key
- Log in as an user with sudo rights
- Create a directory `/etc/cert`
- Copy the `ca.der` and `*.p12` to `/etc/cert`
- Make sure the files are owned by root
- Set strict permissions on the files: `sudo chmod 400 /etc/cert/*`

## Configure netplan
- Go to `/etc/netplan`
- Locate the configuration file, e.g. `50-cloud-init.yaml`
- Disable the cloud-init's network configuration capabilities as stated in the comments of the configuration file: create a file `/etc/cloud/cloud.cfg.d/99-disable-network-config.cfg` with content `network: {config: disabled}`.
- Add the `wifis` section to the configuration file. Replace the <...> sections with corresponding information:

```
network:
    ethernets:
        eth0:
            dhcp4: true
            optional: true
    version: 2
    wifis:
      wlan0:
        access-points:
          <ssid>:
            auth:
              key-management: eap
              method: tls
              anonymous-identity: "anonymous@localhost"
              ca-certificate: /etc/cert/ca.der
              client-key: /etc/cert/<user>.p12
              client-key-password: "<Password private key>"
        dhcp4: yes
```
- Apply the new configuration: `sudo netplan apply` and reboot


