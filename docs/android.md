# Android 10 EAP-TLS Wifi installation
This document describes the necessary steps to connect an Android 10 smartphone to a Wifi network protected with EAP-TLS
To start with you need the CA certificate (ca.der), key/certificate pair (in a *.p12 file) and the accompanying password generated with the manageusers.sh in your FreeRadius installation.

## Import certificates
- Move ca.der and key/certificate file (*.p12) in provision dir to Google Drive (e.g. use scp to copy files to PC followed by upload in browser)
- On smartphone, go to Settings, Security, Advanced, Encryption and data, Install from SD-Card
- Go to My Drive and select ca.der. Then choose Wifi and answer questions. As certificate name, choose e.g. 'Wifica' 
- Go to Install from SD-Card followed by My Drive again. Select *.p12 and type the password. Processing can take very long.
- Enter a certificate name (e.g. Wifiusercert) and select Wifi for usage. Finish.

## Configure Wifi on smartphone
- On smartphone go to Settings, Network and internet
- Select Wifi network (SSID) to connect to with EAP-TLS
- Select 'TLS' as EAP-method
- Select CA-certificate and Usercertificate that you have imported
- Enter 'anonymous' as identity and click 'Connect' 

Remove the certificates from Google Drive
