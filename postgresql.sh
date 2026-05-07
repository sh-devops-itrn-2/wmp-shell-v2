source common.sh

echo -e "${YC}Install PostgreSQL Repo"
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm &>>OUTPUT
status $?

echo -e "${YC}Disable PostgreSQL${NC}"
dnf -qy module disable postgresql &>>OUTPUT
status $?

echo -e "${YC}Install PostgreSQL 16${NC}"
dnf install -y postgresql16-server postgresql16 &>>OUTPUT
status $?

echo -e "${YC}Initialize Database${NC}"
/usr/pgsql-16/bin/postgresql-16-setup initdb &>>OUTPUT
if [ $? -ne 0 ]; then
 /usr/pgsql-16/bin/postgresql-16-setup initdb &>>OUTPUT
 echo -e "${GC}Initalized${NC}"
fi

echo -e "${YC}Edit the PostgreSQL configuration file${NC}"
sed -i "/listen_addresses/ c listen_addresses = '*'" /var/lib/pgsql/16/data/postgresql.conf
status $?



