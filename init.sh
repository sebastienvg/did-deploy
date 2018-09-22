#!/bin/bash
## if you pass --base flag it will install/reinstall postgres data
# decrypt things
ansible-vault decrypt --vault-password-file=deploy-vault.pass pgdata.tar.gz docker-compose.yml

		if [ $1 == --base ]
		then
			tar xzf pgdata.tar.gz
		fi

docker-compose up -d

echo "You should be able to login to http://localhost:8053 with admin/admin"

