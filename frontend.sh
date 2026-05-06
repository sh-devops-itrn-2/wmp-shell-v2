source common.sh

echo -e "${YC}Disable Nginx${NC}"
dnf module disable nginx -y  &>>OUTPUT
status $?

echo -e "${YC}Enable Nginx${NC}"
dnf module enable nginx:1.26 -y &>>OUTPUT
status $?

echo -e "${YC}Install Nginx${NC}"
dnf install -y nginx &>>OUTPUT
status $?

echo -e "${YC}Copy nginx config file${NC}"
cp nginx.conf /etc/nginx/nginx.conf &>>OUTPUT
status $?

echo -e "${YC}Download and nodejs 22 repo${NC}"
curl -fsSL https://rpm.nodesource.com/setup_22.x | bash - &>>OUTPUT
status $?

echo -e "${YC}Install nodejs${NC}"
dnf install -y nodejs &>>OUTPUT
status $?

echo -e "${YC}Download App content${NC}"
curl -L -o /tmp/frontend.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/frontend.tar.gz &>>OUTPUT
status $?

echo -e "${YC}Create Directory${NC}"
mkdir -p /tmp/frontend
status $?

echo -e "${YC}Extract App content${NC}"
cd /tmp/frontend
tar xzf /tmp/frontend.tar.gz &>>OUTPUT
status $?

echo -e "${YC}Download Dependencies${NC}"
cd /tmp/frontend
npm ci &>>OUTPUT
npm run build &>>OUTPUT
status $?

echo -e "${YC}Remove default content${NC}"
rm -rf /usr/share/nginx/html/* &>>OUTPUT
status $?

echo -e "${YC}Copy App contents ${NC}"
cp -r /tmp/frontend/dist/* /usr/share/nginx/html/
status $?

echo -e "${YC}Enable Nginx${NC}"
systemctl enable nginx &>>OUTPUT
status $?

echo -e "${YC}Start Nginx${NC}"
systemctl start nginx
status $?

