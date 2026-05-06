status(){
if [ $? -eq 0 ]; then
  echo "${GC}Success${NC}"
  else
  echo "${RC}Failure${NC}"
fi

}



RC="\e[31m"
YC="\e[33m"
GC="\e[32m"
NC="\e[0m"

OUTPUT=/tmp/wmp.log

