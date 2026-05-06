source common.sh

echo "${YC}Disable Nginx${NC}"
dnf module disable nginx -y  &>>OUTPUT
status $?

echo "${YC}Enable Nginx${NC}"
dnf module enable nginx:1.26 -y &>>OUTPUT
status $?

echo "${YC}Install Nginx${NC}"
dnf install -y nginx &>>OUTPUT
status $?

echo "${YC}Copy nginx config file${NC}"
cp nginx.conf /etc/nginx/nginx.conf &>>OUTPUT
status $?

echo "${YC}Download and nodejs 22 repo${NC}"
curl -fsSL https://rpm.nodesource.com/setup_22.x | bash - &>>OUTPUT
status $?

echo "${YC}Install nodejs${NC}"
dnf install -y nodejs &>>OUTPUT
status $?

echo "${YC}Download App content${NC}"
curl -L -o /tmp/frontend.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/frontend.tar.gz &>>OUTPUT
status $?

echo "${YC}Create Directory${NC}"
mkdir -p /tmp/frontend
status $?

echo "${YC}Extract App content${NC}"
cd /tmp/frontend
tar xzf /tmp/frontend.tar.gz &>>OUTPUT
status $?

echo "${YC}Download Dependencies${NC}"
cd /tmp/frontend
npm ci &>>OUTPUT
npm run build &>>OUTPUT
status $?

echo "${YC}Remove default content${NC}"
rm -rf /usr/share/nginx/html/* &>>OUTPUT
status $?

echo "${YC}Copy App contents ${NC}"
cp -r /tmp/frontend/dist/* /usr/share/nginx/html/
status $?

echo "${YC}Enable Nginx${NC}"
systemctl enable nginx &>>OUTPUT
status $?

echo "${YC}Start Nginx${NC}"
systemctl start nginx
status $?

