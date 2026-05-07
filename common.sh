status(){
if [ $? -eq 0 ]; then
  echo -e  "${GC}Success${NC}"
  else
  echo -e "${RC}Failure${NC}"
fi

}
user_add(){
id appuser &>/dev/null
if [ $? -ne 0 ]; then
useradd -r -s /bin/false appuser &>>OUTPUT
else
echo -e "${YC}User Already Exists${NC}"
fi
}

app_pre_req(){
  mkdir -p /app
  curl -L -o /tmp/${service_name}.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/${service_name}.tar.gz
  cd /app
  tar xzf /tmp/${service_name}.tar.gz

}


RC="\e[31m"
YC="\e[33m"
GC="\e[32m"
NC="\e[0m"

OUTPUT=/tmp/wmp.log

