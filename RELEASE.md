[v3.0.25p1]
Some minor changes:
- Bump Alpine linux version to 3.16, FreeRADIUS version stays on v3.0.25
- Fix execute rights of some scripts in this repository and set correctly in container
- Fix the test configuration in ./test/tls.conf, some paths where not correct

[v3.0.25]
Release of wifi_eap-tls based on Alpine Linux and FreeRADIUS 3.0.25 from the stable branch. This release is using the Docker image of the 3.15.0 release of Alpine Linux. A small improvement to the usability of wifi_eap-tls has been made bij adding a `RadiusServerName.txt` file in the provision directory which contains the name of the Radius server. This value is needed to configure e.g. Android 11 clients. Also the quality of the shell scripts has been improved by using https://www.shellcheck.net/. 

[v3.0.24]
This version was never released as the corresponding FreeRADIUS version was shortlived.

[v3.0.23-p1]
Release of wifi_eap-tls based on Alpine Linux and FreeRADIUS 3.0.23 from the stable branch. This release is using the Docker image of the 3.14.0 release of Alpine Linux. If used with an older version of Docker you will get errors like  `make: *** [Makefile:49: passwords.mk] Error 127` when using the management scripts. See https://wiki.alpinelinux.org/wiki/Release_Notes_for_Alpine_3.14.0#faccessat2 for details. 

[v3.0.23]
Release of wifi_eap-tls based on Alpine Linux and FreeRADIUS 3.0.23 from the edge branch. For upgrade procedure, see the UPGRADE.md procedure

[v3.0.22b]
Beta release of wifi_eap-tls based on Alpine Linux and FreeRADIUS 3.0.22 from the edge branch. For upgrade procedure, see the UPGRADE.md procedure

[v3.0.21]
First release of wifi_eap-tls based on Alpine Linux and FreeRADIUS 3.0.21

