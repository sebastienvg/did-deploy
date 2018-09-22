#!/bin/bash

## stop the containers if they are already running
./stop-deploy-server.sh
## decrypt files
ansible-vault decrypt --vault-password-file=deploy-vault.pass pgdata.tar.gz docker-compose.yml

## if deploy-vault.pass is empty or if content is not good EXIT
deploypass=$(cat deploy-vault.pass)

echo "key is $deploypass"

if [ $deploypass == x]
	then
		echo "You don't have a valid licence"
else
	## if you pass --base flag it will install/reinstall postgres data 
	if [ $1 == --base ]
                then
			ansible-vault decrypt --vault-password-file=deploy-vault.pass pgdata.tar.gz docker-compose.yml
                        tar xzf pgdata.tar.gz
                fi	
        ansible-vault decrypt --vault-password-file=deploy-vault.pass pgdata.tar.gz docker-compose.yml
	./start-deploy-server.sh
fi

## if you want to start without data reset
if [ $1 == --start]
	then
		./start-deploy-server.sh
fi


#./start-deploy-server.sh

#echo "You should be able to login to http://localhost:8053 with admin/admin"

