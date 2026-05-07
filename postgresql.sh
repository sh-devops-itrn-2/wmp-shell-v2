source common.sh

echo -e "${YC}Install PostgreSQL Repository${NC}"
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm &>>$OUTPUT
status_check

echo -e "${YC}Install PostgreSQL${NC}"
dnf -qy module disable postgresql &>>$OUTPUT
dnf install -y postgresql16-server postgresql16 &>>$OUTPUT
status_check

echo -e "${YC}Initialize Database${NC}"
/usr/pgsql-16/bin/postgresql-16-setup initdb &>>$OUTPUT
status_check

echo -e "${YC}Start PostgreSQL Service${NC}"
systemctl enable postgresql-16 &>>$OUTPUT
systemctl start postgresql-16 &>>$OUTPUT
status_check

echo -e "${YC}Update PostgreSQL Config${NC}"
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/16/data/postgresql.conf &>>$OUTPUT
echo "host    all    all    0.0.0.0/0    scram-sha-256" >> /var/lib/pgsql/16/data/pg_hba.conf
sed -i 's/local   all             all                                     peer/local   all             all                                     trust/' /var/lib/pgsql/16/data/pg_hba.conf &>>$OUTPUT
status_check

echo -e "${YC}Restart PostgreSQL Service${NC}"
systemctl restart postgresql-16 &>>$OUTPUT
status_check

echo -e "${YC}Run Setup SQL${NC}"
sudo -u postgres /usr/pgsql-16/bin/psql < setup.sql &>>$OUTPUT
status_check