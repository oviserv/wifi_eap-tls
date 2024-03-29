# Android 10 & 11 EAP-TLS Wifi installation
This document describes the necessary steps to connect an Android 10 or 11 smartphone to a Wifi network protected with EAP-TLS.
To start with you need the CA certificate (ca.der), key/certificate pair (in a *.p12 file) and the accompanying password generated with the manageusers.sh in your FreeRadius installation. For Android 11 you also need the `commonName` of the Radius server certificate. The `commonName` is available in de `RadiusServerName.txt` file in the provision directory.

## Import certificates
- Move ca.der and key/certificate file (*.p12) in provision dir to Google Drive (e.g. use scp to copy files to PC followed by upload in browser)
- On the smartphone, go to Settings, Security, Advanced, Encryption and data, Install from SD-Card. Between devices naming and location can differ. On recent Samsung devices search for 'Install from device storage (Install certificates from storage)' under 'Other security settings'.
- For Android 11, choose "Wi-Fi-certificate" for the ca.der and the key/certificate file (*.p12).
- Go to My Drive and select ca.der. Then choose Wifi and answer questions. As certificate name, choose e.g. 'Wifica' 
- Go to Install from SD-Card (choose "Wifi-certificate for Android 11 again) followed by My Drive. Select *.p12 and type the password. Processing can take very long.
- Enter a certificate name (e.g. Wifiusercert) and select Wifi for usage. Finish.

## Configure Wifi on smartphone
- On smartphone go to Settings, Network and internet
- Select Wifi network (SSID) to connect to with EAP-TLS
- Select 'TLS' as EAP-method
- Android 11: For Online certificate status, choose 'Do not validate'
- Select the CA-certificate and Usercertificate that you have imported
- For Domain, enter the commonName of the Radius server certificate.
- Enter 'anonymous' as Identity and click 'Connect' 
- Remove the certificates from Google Drive

