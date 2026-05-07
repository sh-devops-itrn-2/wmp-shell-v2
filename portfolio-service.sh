source common.sh

echo -e "${YC}Install Java 21${NC}"
dnf install -y java-21-openjdk-devel &>>OUTPUT
status

appuser=app_user
echo -e "${YC}Add Application User${NC}"
id appuser &>/dev/null
if [ $? -ne 0 ]; then
useradd -r -s /bin/false appuser &>>OUTPUT
else
echo "${YC}User Already Exists${NC}"
fi

echo -e "${YC}Create Directory${NC}" &>>OUTPUT
mkdir -p /app
status

echo -e "${YC}Download App Content${NC}"
curl -L -o /tmp/portfolio-service.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/portfolio-service.tar.gz &>>OUTPUT
status

echo -e "${YC}Copy systemd file${NC}"
cp -r portfolio-service.service /etc/systemd/system/portfolio-service.service
status

echo -e "${YC}Change Directory${NC}"
cd /app
status

echo -e "${YC}Extract App Content${NC}"
tar xzf /tmp/portfolio-service.tar.gz &>>OUTPUT
status

echo -e "${YC}Build Application${NC}"
./gradlew bootJar --no-daemon -x test &>>OUTPUT
status

echo -e "${YC}Copy the built JAR${NC}"
cp /app/build/libs/*.jar /app/portfolio-service.jar
status

echo -e "${YC}Set ownership${NC}"
chown -R appuser:appuser /app
status

echo -e "${YC}Remove Others Permission${NC}"
chmod o-rwx /app -R
status


echo -e "${YC}Portfolio Service Started"
systemctl daemon-reload
systemctl enable portfolio-service &>>OUTPUT
systemctl start portfolio-service
status

