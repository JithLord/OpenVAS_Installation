#Run
sudo -s
sudo apt update
sudo apt upgrade

apt-get install openvas
gvm-setup

echo "If error is received:"
echo "[-] ERROR: The default PostgreSQL version (15) is not 16 that is required by libgvmd"

echo "This is because ibgvmd needs PostgreSQL 16 to use the port 5432"
echo "So change PostgreSQL 15 to port 5433 and PostgreSQL to port 5432"
echo "Use gedit or Nano or vim for this"

service postgresql restart
gvm-setup
gvm-check-setup
systemctl status opsd-openvas.service

chmod 777 /var/log/gvm/openvas.log 
echo "ERROR: The new extension pgcrypto does not exist for gvmd database
        FIX: Run 'sudo runuser -u postgres -- /usr/share/gvm/create-postgresql-database'"

sudo runuser -u postgres -- /usr/share/gvm/create-postgresql-database
echo "set version to 16.0 below"
gedit /usr/share/gvmd/postgresql 

sudo apt install postgresql-16-pg-gvm
sudo runuser -u postgres -- /usr/share/gvm/create-postgresql-database

gvm-check-setup
echo "username and password are admin"
sudo runuser -u _gvm -- gvmd --create-user=admin --password=admin   
