status(){
if [ $? -eq 0 ]; then
  echo -e  "${GC}Success${NC}"
  else
  echo -e "${RC}Failure${NC}"
fi

}
user_add(){
echo -e  "${YC}Adding User${NC}"
id appuser &>/dev/null
if [ $? -ne 0 ]; then
useradd -r -s /bin/false appuser &>>OUTPUT
else
echo -e "${YC}User Already Exists${NC}"
fi
}

app_pre_req(){
  mkdir -p /app
  curl -L -o /tmp/${service_name}.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/${service_name}.tar.gz &>>OUTPUT
  cd /app
  tar xzf /tmp/${service_name}.tar.gz &>>OUTPUT

}
set_ownership(){
  echo -e "${YC}Set ownership and permission${NC}"
  chown -R appuser:appuser /app
  chmod o-rwx /app -R
  status
}
start_service() {
  echo -e "${YC}Start ${service_name} Service${NC}"
  systemctl daemon-reload &>>$OUTPUT
  systemctl enable ${service_name} &>>$OUTPUT
  systemctl start ${service_name} &>>$OUTPUT
  status
}
RC="\e[31m"
YC="\e[33m"
GC="\e[32m"
NC="\e[0m"

OUTPUT=/tmp/wmp.log

