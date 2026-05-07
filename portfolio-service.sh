source common.sh

echo -e "${YC}Install Java 21${NC}"
dnf install -y java-21-openjdk-devel &>>OUTPUT
status
