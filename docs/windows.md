##Windows 10 EAP-TLS Wifi installation
This document describes the necessary steps to connect a Windows 10 machine to a Wifi network protected with EAP-TLS
To start with you need the CA certificate (ca.der), key/certificate pair (in a *.p12 file) and the accompanying password generated with the manageusers.sh in your FreeRadius installation.

#Install CA certificate
- Log in as a user with administrative rights
- Right click ca.der and select 'Install Certificate'
- Choose as Store Location 'Local Machine' and click next
- Select 'Place all certificates in the following store' and browse to the 'Trusted Root Certification Authorities' certificate store. Click next and finish

#Install user certificate and key
- Log in as a user with administrative rights
- Right click the file with certificate and key (p12 extension) and choose 'Install PFX'
- Choose as Store Location 'Local Machine' and click next (2x)
- Enter the password for the private key and click next
- Select 'Place all certificates in the following store' and browse to the 'Personal' certificate store. Click next and finish

#Configure Wifi network
- Log in as a user with administrative rights
- Open the 'Network and Sharing Center'
- Click 'Set up a new connection or network'
- Select 'Manually connect to a wireless network' and click next
- Enter the Network name (SSID)
- Select as Security type 'WPA2-Enterprise' and click next
- Click 'Change connection settings'
- Select the 'Security' tab
- Select as network authentication method 'Microsoft: Smart Card or other certificate'
- Click 'Settings' followed by 'Advanced'
- Select 'Certificate Issuer' and select your CA from the list (Starts with 'Wifi Certificate Authority' followed by a date code. Click 'Ok'
- Deselect 'Use simple certificate selection (Recommended)'
- Select under Trusted Root Certification Authorities once again your CA from the list and click 'Ok' (2x) followed by 'Close'
- You can now connect to your Wifi network
