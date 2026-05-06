source common.sh

echo -e "${YC}Install PostgreSQL Repo"
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm &>>OUTPUT
status $?

