#!/bin/bash

deploypass=$(cat deploy-vault.pass)

if  [ '$deploypass' == x ]
	then
		echo "You don't have a valid licence"
		exit
elif [ '$deploypass' != x ]
then
	## if you pass --base flag it will install/reinstall postgres data
	if [ $1 == '--base' ]
                then
			ansible-vault decrypt --vault-password-file=deploy-vault.pass pgdata.tar.gz  2>/dev/null
		echo "pgdata decrypted"
			ansible-vault decrypt --vault-password-file=deploy-vault.pass docker-compose.yml  2>/dev/null
		echo "compose file decrypted"
			ansible-vault decrypt --vault-password-file=deploy-vault.pass id_rsa  2>/dev/null
                echo "id_rsa decrypted"
			ansible-vault decrypt --vault-password-file=deploy-vault.pass id_rsa.pub  2>/dev/null
                echo "id_rsa.pub decrypted"
			#ansible-vault decrypt --vault-password-file=deploy-vault.pass stop-deploy-server.sh  2>/dev/null
			ansible-vault decrypt --vault-password-file=deploy-vault.pass start-deploy-server.sh 2>/dev/null
		echo "unpacking"
                        tar xzf pgdata.tar.gz
	 	        sh start-deploy-server.sh
                fi
#        ansible-vault decrypt --vault-password-file=deploy-vault.pass pgdata.tar.gz docker-compose.yml stop-deploy-server.sh start-deploy-server.sh 2>/dev/null
	 sh start-deploy-server.sh
echo "You should be able to login to http://localhost:8053 with admin/admin"
fi

