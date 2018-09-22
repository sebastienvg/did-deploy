#!/bin/bash
# decrypt things
ansible-vault decrypt --vault-password-file=deploy-vault.pass pgdata.tar.gz docker-compose.yml



		if [ $1 == 1 ]
		then
			tar xzf pgdata.tar.gz
		fi





docker-compose up -d

echo "You should be able to login to http://localhost:8053 with admin/admin"

