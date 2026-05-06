source common.sh

echo "${YC}Disable Nginx${NC}"
dnf module disable nginx -y  &>>OUTPUT

echo "${YC}Enable Nginx${NC}"
dnf module enable nginx:1.26 -y

echo "${YC}Install Nginx${NC}"
dnf install -y nginx

echo "${YC}Copy nginx config file${NC}"
cp nginx.conf /etc/nginx/nginx.conf

echo "${YC}Download and nodejs 22 repo${NC}"
curl -fsSL https://rpm.nodesource.com/setup_22.x | bash -
dnf install -y nodejs

echo "${YC}Download App content${NC}"
curl -L -o /tmp/frontend.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/frontend.tar.gz

echo "${YC}Create Directory${NC}"
mkdir -p /tmp/frontend

echo "${YC}Extract App content${NC}"
cd /tmp/frontend
tar xzf /tmp/frontend.tar.gz

echo "${YC}Download Dependencies${NC}"
cd /tmp/frontend
npm ci
npm run build

echo "${YC}Remove default content${NC}"
rm -rf /usr/share/nginx/html/*

echo "${YC}Copy App contents ${NC}"
cp -r /tmp/frontend/dist/* /usr/share/nginx/html/

echo "${YC}Enable Nginx${NC}"
systemctl enable nginx

echo "${YC}Start Nginx${NC}"
systemctl start nginx


