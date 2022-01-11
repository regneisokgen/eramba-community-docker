#!/bin/sh

# set -x

ERAMBADBCONF=/app/app/Config/database.php
MAXTRIES=20

wait4mysql () {
echo "[i] Waiting for database to setup..."

for i in $(seq 1 1 $MAXTRIES)
do
	echo "[i] Trying to connect to database: try $i..."
	mysql -B --connect-timeout=1 -h $MYSQL_HOSTNAME -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE 

	if [ "$?" = "0" ]; then
		echo "[i] Successfully connected to database!"
		break
	else
		if [ "$i" = "$MAXTRIES" ]; then
			echo "[!] You need to have container for database. Take a look at docker-compose.yml file!"
			exit 0
		else
			sleep 5
		fi
	fi
done
}

wait4mysql
