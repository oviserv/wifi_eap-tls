To start with an clean environment, execute the follow actions
- This cleans all data! Make backups first!
- Go to the directory with the docker-compose.yml file
- Give command `docker-compose down --rmi all`
- Remove all backups from ./backup (or move them to another location)
- Remove all files from ./provision
- Give command `docker volume rm freeradius_raddb`
- Give command `docker-compose build`
- Or run ./scripts/clean.sh in directory where docker-compose.yml resides

To start a rootshell in an unitialized environment:
- Comment out `entrypoint: "./managecerts.sh"` for prepare_radiusd in docker-compose.yml
- `docker-compose run prepare_radiusd sh` This command drops you in a root shell ready to run all scripts.
- Start with `./managecerts.sh` to initialize.

Test tooling
A few tools can be used to test and debug FreeRadius:
- radclient (in freeradius-utils package)
- eapol_test (in wpa_supplicant package)

Sometimes the c_rehash tool is mentioned. This tool is available in the ca-certificates package. Enable these packages in the Dockerfile
 
To create patches from the configuration files
- Open a rootshell in an unitialized environment (see before)
- Copy the configuration file to <config name>.orig if it doesn't already exists
- Edit the configuration file
- Get a diff with: diff -u <full path to config>.orig <full path to config> > /backup/<config name>.patch
- Watch out for passwords embedded in the configuration files
- Move the file to the patch dir in the GIT repository in the host system
- Check in bootstrap.sh if the file is patched. If not, add a patch command
- The patch will be applied on the next build of the container
