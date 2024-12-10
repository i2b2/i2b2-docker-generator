
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y postgresql postgresql-contrib

/etc/init.d/postgresql status
/etc/init.d/postgresql start

echo "started postgresql service on ubuntu container"


#updating postgresql configuration

sed -i "0,/#listen_addresses = 'localhost'/s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/16/main/postgresql.conf

sed -i 's/local   all             postgres                                peer/local   all             postgres                                trust/' /etc/postgresql/16/main/pg_hba.conf

sed -i 's/local   all             all                                     peer/local   all             all                                     md5/' /etc/postgresql/16/main/pg_hba.conf

sed -i 's#host    all             all             127.0.0.1/32            scram-sha-256#host    all             all             0.0.0.0/0            scram-sha-256#g' /etc/postgresql/16/main/pg_hba.conf

user_name=$(whoami)
/etc/init.d/postgresql restart

