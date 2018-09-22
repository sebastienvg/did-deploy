#!/bin/bash

## stop the containers if they are already running
#./stop-deploy-server.sh	2>/dev/null
## decrypt files
#ansible-vault decrypt --vault-password-file=deploy-vault.pass pgdata.tar.gz docker-compose.yml stop-deploy-server.sh start-deploy-server.sh 2>/dev/null

## if deploy-vault.pass is empty or if content is not good EXIT
deploypass=$(cat deploy-vault.pass)

#echo "key is $deploypass"

if  [ '$deploypass' == x ]
	then
		echo "You don't have a valid licence"
		exit
elif [ '$deploypass' != x ]
then
	## if you pass --base flag it will install/reinstall postgres data
	if [ $1 == '--base' ]
                then
			ansible-vault decrypt --vault-password-file=deploy-vault.pass pgdata.tar.gz docker-compose.yml stop-deploy-server.sh start-deploy-server.sh 2>/dev/null
                        tar xzf pgdata.tar.gz
                fi
        ansible-vault decrypt --vault-password-file=deploy-vault.pass pgdata.tar.gz docker-compose.yml stop-deploy-server.sh start-deploy-server.sh 2>/dev/null
	 sh start-deploy-server.sh
echo "You should be able to login to http://localhost:8053 with admin/admin"
fi

## if you want to start without data reset
if [ $1 == '--start' ]
	then
		sh start-deploy-server.sh
echo "You should be able to login to http://localhost:8053 with admin/admin"
fi


