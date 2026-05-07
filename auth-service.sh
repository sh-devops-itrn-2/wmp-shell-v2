source common.sh
service_name=auth-service

echo -e "${YC}Install Golang${NC}"
dnf install -y golang &>>$OUTPUT
status_check

echo -e "${YC}Copy Service File${NC}"
cp ${service_name}.service /etc/systemd/system/${service_name}.service &>>$OUTPUT
status_check

echo -e "${YC}Download and Extract Application${NC}"
app_prereq
status_check

echo -e "${YC}Build Application${NC}"
cd /app
CGO_ENABLED=0 go build -o ${service_name} ./cmd/server &>>$OUTPUT
status_check

set_permissions
start_service