To start with a clean environment, execute the follow actions
- This cleans all data! Make backups first!
- Go to the directory with the docker-compose.yml file
- Run `docker-compose down --rmi all`
- Remove all backups from ./backup (or move them to another location)
- Remove all files from ./provision
- Run `docker volume rm freeradius_raddb`
- Run `docker-compose build`
- Or run ./scripts/clean.sh in directory where docker-compose.yml resides

To start a rootshell in an unitialized environment:
- Comment out `entrypoint: "./managecerts.sh"` for prepare_radiusd in docker-compose.yml
- `docker-compose run prepare_radiusd sh` This command drops you in a root shell ready to run all scripts.
- Start with `./managecerts.sh` to initialize.

Test tooling
A few tools can be used to test and debug FreeRadius:
- radclient (in freeradius-utils package). The simple authentication methods that radclient supports are disabled in this configuration. So you can use radclient to test if these methods are disabled indeed.
- eapol_test (in wpa_supplicant package)
- Under the test directory the tls.conf configuration file is available. To use this file
  - Copy the file to the provision directory
  - Start the Freeradius server in foreground mode (docker-compose up)
  - Switch to a second shell
  - Run `./scripts/start_management.sh` in the directory where docker-compose.yml resides
  - Use `./manageclients.sh` to add the default testing client
  - Use `./manageusers.sh` to create a test user.
  - Close the shell and reopen. The radiusd container will restart
  - Go to the `/provision` directory and edit tls.conf
  - Run the eapol_test command as shown in the comments in tls.conf

Sometimes the c_rehash tool is mentioned. This tool is available in the ca-certificates package.
 
To create patches from the configuration files
- Open a rootshell in an unitialized environment (see before)
- Copy the configuration file to <config name>.orig if it doesn't already exists
- Edit the configuration file
- Get a diff with: diff -u <full path to config>.orig <full path to config> > /backup/<config name>.patch
- Watch out for passwords embedded in the configuration files
- Move the file to the patch dir in the GIT repository in the host system
- Check in bootstrap.sh if the file is patched. If not, add a patch command
- The patch will be applied on the next build of the container
