# iOS EAP-TLS Wifi installation
This document describes the necessary steps to connect an iOS device to a Wifi network protected with EAP-TLS. This procedure was tested on an iPad with iOS 13.6.1. To start with you need the CA certificate (ca.der), key/certificate pair (in a *.p12 file) and the accompanying password generated with the manageusers.sh in your FreeRadius installation.

## Import certificates
- Copy certificates to your iCloud account
- Using the file browser on your iOS device, install the certificates
- Under Settings, install the new certificates

## Configure Wifi on iOS device
- Go to Wifi in settings
- Select the SSID of the Wifi network you want to use
- Select EAP-TLS as modus
- Select the installed certificate as identity
- Enter 'anonymous' as username
- Click 'connect'
- Accept the CA certificate
