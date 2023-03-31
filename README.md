# Secure Wifi: WPA3 & WPA2 Enterprise with EAP-TLS
Wifi is nearly everywhere and adequate security is important. User friendly and secure alternative to the password based solution is WPA3 & WPA2 Enterprise (further: WPA2 Enterprise). One of the options within WPA2 Enterprise is EAP-TLS. This authentication protocol uses X.509 certificates to make sure that a user connects to an authentic Wifi network. The client side certificate guarantees to the Wifi network the authenticity of the client. This repository gives some scripts to create and manage some of the key components for an EAP-TLS setup: a RADIUS server and a Public Key Infrastructure (PKI) for managing a Certificate Authority (CA) and managing X.509 certificates. For the RADIUS server the FreeRadius opensource project is used. The complexity of configuring FreeRadius is taken away by using a few wrapper scripts. The RADIUS server is run using Docker and docker-compose.

A complete setup consists of the following elements:
- a Wifi client, e.g. a Windows 11 laptop connecting to a Wifi network
- a Wifi access point supporting RADIUS authentication. The setup presented was tested with Ubiquity UniFi access points and UniFi Network Controller software (no relationship whatsoever between this project and Ubiquiti).
- a RADIUS server and PKI (this project) running on a Docker server with docker-compose. Regular WPA3 Enterprise is tested (and used) succesfully. Necessary changes to use the 192-bit security mode offered by WPA3 Enterprise still have to be determined. Input on this subject is welcomed.

# Getting started
- Start with a functioning Wifi network using WPA2 preshared key
- Clone this repository to a Docker server with docker-compose installed
- Execute the following commands as root (or use sudo) in the main directory of this repository.
- Run `./scripts/init.sh` to create some directories and create the `.env` file.
- Edit the `.env` file in the main directory. Necessary adjustments are documented in the comments in this file.
- Do a `docker-compose build` followed by a `docker-compose up` (this can take some time).
- Wait until the initialization is finished. End with `Ctrl+c` and restart with `docker-compose up -d`
- Run `./scripts/start_management.sh`. This gives a root shell within a directory with some management scripts.
- Run `./manageclients.sh` to get help to register Radius clients. A Radius client is e.g. a Wifi access point.
- Register your Radius clients. Don't forget to take note of the password.
- Create a WPA2 enterprise Wifi network and register the Radius server by IP in the Network controller software. Enable usage of VLAN's supplied by the Radius server if you need this.
- Close the shell using exit (or Ctrl+d).  The radius service will restart.

# Adding your first device using EAP-TLS 
- Execute the following commands as root (or use sudo) in the main directory of this repository.
- Run `./scripts/start_management.sh`. This gives a root shell within a directory with some management scripts.
- Run `./manageusers.sh` to get help to create the key/certificate pair for your device.
- Generate the key/certificate pair. Take note of the password and close the shell.
- In the provision directory you can find the Certificate Authority certificate (ca.der) and the password secured key/certificate file (*.p12). Copy these to your device using an USB stick or e.g. `scp`. In a lab environment a command like `python3 -m http.server 8000` can be used in the provision dir to make the files available.
- Use these files to configure Wifi with EAP-TLS authentication. See for example [Windows instructions](docs/windows.md), [Android instructions](docs/android.md), [Linux instructions](docs/linux.md) or [iOS instructions](docs/ios.md)
