folder=$1
file=$2

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [ $# -lt 2 ]
then 
  echo "${RED}Arguments are needed${NC}"
  echo "${RED}sh premailer.sh <FOLDER> <FILENAME>${NC}"
  exit 1
elif [ $# -gt 2 ]
then
  echo "${RED}sh premailer.sh <FOLDER> <FILENAME>${NC}"
  exit 1
fi

irb premailer.rb $folder $file

if [ -d "$folder/premailer-ed" ]
then
  mv $folder/$file-premailer.html $folder/premailer-ed/$file-premailer.html
  mv $folder/$file-log.txt $folder/logs/$file-log.txt
  echo "${GREEN}Processed HTML moved successfully${NC}"
else
  mkdir $folder/premailer-ed
  mv $folder/$file-premailer.html $folder/premailer-ed/$file-premailer.html
  echo "${GREEN}Directory didn't exist and was created${NC}"
  echo "${GREEN}Processed HTML moved successfully${NC}"
fi

if [ -d "$folder/logs" ]
then
  mv $folder/$file-premailer.html $folder/premailer-ed/$file-premailer.html
  mv $folder/$file-log.txt $folder/logs/$file-log.txt
  echo "${GREEN}Logs moved successfully${NC}"
else
  mkdir $folder/logs
  mv $folder/$file-log.txt $folder/logs/$file-log.txt
  echo "${GREEN}Directory didn't exist and was created${NC}"
  echo "${GREEN}Logs moved successfully${NC}"
fi
