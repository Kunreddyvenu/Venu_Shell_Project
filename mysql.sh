USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "please enter DB password"
read -s mysql_root_password

VALIDATE(){

    if [ $1 -ne 0 ]
    then
       echo -e "$2 ... $R FAILURE $N"
       exit 1 #manually exit if error comes
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}
if [ $USERID -ne 0 ]
then
   echo "please run the script with super user."
   exit 1 #manually exits if error comes.
else 
   echo "you are super user."

fi

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "installing MYSQL Server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "enabling sql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "starting mysql server"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
VALIDATE $? "setting up root password"




