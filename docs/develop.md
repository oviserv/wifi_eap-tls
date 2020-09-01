To start with an clean environment, execute the follow actions
- This cleans all data! Make backups first!
- Go to the directory with the docker-compose.yml file
- Give command `docker-compose down --rmi all`
- Remove all backups from ./backup (or move them to another location)
- Remove all files from ./provision
- Give command `docker volume rm freeradius_raddb`
- Give command `docker-compose build`

To start a rootshell in an unitialized environment:
- Comment out `entrypoint: "./managecerts.sh"` for prepare_radiusd in docker-compose.yml
- `docker-compose run prepare_radiusd sh` This command drops you in a root shell ready to run all scripts.
- Start with `./managecerts.sh` to initialize.

To create patches from the configuration files
- Open a rootshell in an unitialized environment (see before)
- Copy the configuration file to <config name>.orig if it doesn't already exists
- Edit the configuration file
- Get a diff with: diff -u <full path to config>.orig <full path to config> > /backup/<config name>.patch
- Watch out for passwords embedded in the configuration files
- Move the file to the patch dir in the GIT repository in the host system
- Check in bootstrap.sh if the file is patched. If not, add a patch command
- The patch will be applied on the next build of the container
