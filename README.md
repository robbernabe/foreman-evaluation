# foreman evaluation

A multi-machine Vagrantfile and associated scripts to spin up a puppetmaster
using [foreman](http://theforeman.org/) and a single puppet node.

*NOTE:* I could not successfully install the latest stable version of foreman on
Ubuntu Trusty (14.04LTS), so this Vagrantfile is using Ubuntu Precise (12.04LTS). I 
believe its a problem with the version of puppet installed using the trusty APT
repo from puppetlabs, but not 100% sure.

## requirements

* vagrant (tested on 1.6.5)
* virtualbox (tested on 4.3.20)
* vagrant-hostmanager plugin

## how to

Simply run:

	vagrant up

Once complete, you can login to the foreman puppetmaster at:

	https://foreman.local/

Credentials are admin / admin

The one puppet node will have already tried connecting to the puppetmaster, so
you'll need to sign the certificate on the puppetmaster. You can do that via the
UI by going to:

	Infrastructure -> Smart Proxies

then click on the "Certificates" button for the "foreman.local" host. You should
see a listing for "agent1" in the pending state. Click the sign button.

Finally, run the following command to invoke agent runs and see some data on the
dashboard:

	for i in foreman agent1; do
		vagrant ssh $i -c "sudo puppet agent -vtd"
	done

Now you've got a connected agent and can assign classes, etc.

Enjoy!
