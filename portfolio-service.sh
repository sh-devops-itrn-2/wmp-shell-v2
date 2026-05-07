source common.sh
service_name=portfolio-service

echo -e "${YC}Install Java 21${NC}"
dnf install -y java-21-openjdk-devel &>>OUTPUT
status

user_add

echo -e "${YC}Copy Service File${NC}"
cp ${service_name}.service /etc/systemd/system/${service_name}.service &>>$OUTPUT
status_check


app_pre_req

echo -e "${YC}Build Application${NC}"
./gradlew bootJar --no-daemon -x test &>>OUTPUT
status

echo -e "${YC}Copy the built JAR${NC}"
cp /app/build/libs/*.jar /app/portfolio-service.jar
status

set_ownership

start_service

