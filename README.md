# Secure Wifi: WPA2 Enterprise with EAP-TLS for home use
Wifi is nearly everywhere and adequate security is important. User friendly and secure alternative to the password based solution is WPA2 Enterprise. One of the options within WPA2 Enterprise is EAP-TLS. This authentication protocol uses X.509 certificates to make sure that a user connects to an authentic Wifi network. The client side certificate guarantees to the Wifi network the authenticity of the client. This repository gives some scripts to create and manage some of the key components for an EAP-TLS setup: a RADIUS server and a Public Key Infrastructure (PKI) for managing a Certificate Authority (CA) and managing X.509 certificates. For the RADIUS server the FreeRadius opensource project is used. The complexity of configuring FreeRadius is taken away by using a few wrapper scripts. The RADIUS server is run using Docker and docker-compose.

A complete setup consists of the following elements:
- a Wifi client, e.g. a Windows 10 laptop connecting to a Wifi network
- a Wifi access point supporting RADIUS authentication. This setup presented was tested with Ubiquity UniFi access points and UniFi Network Controller software (no relationship whatsoever between this project and Ubiquiti)
- a RADIUS server and PKI (this project) running on a Docker server
