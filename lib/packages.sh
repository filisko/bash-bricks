#!/usr/bin/env bash

# if ! [[ "$OSTYPE" == "darwin"* ]] && ! [[ "$OSTYPE" == "linux"* ]]; then
#     echo "You are not using Mac or Linux";
#     exit 1
# fi

# declare -a deps=("httpie" "mycli" "pup" "jq")

# if [[ "$OSTYPE" == "darwin"* ]]; then
#   echo "MacOS was detected ..."

#   if ! which brew > /dev/null; then
#     echo "install brew and know what it is ;) https://brew.sh/"
#     exit 1
#   fi

#   for dep in "${deps[@]}"; do
#     echo -n $(yellow "checking if $dep is installed... ") 
    
#     if ! brew ls --versions "$dep" > /dev/null; then
#       echo $(error)
#       echo $(green "installing "$dep" ...") 
#       brew install "$dep"
#     else
#       echo $(success) 
#     fi
#   done
# fi

# if [[ "$OSTYPE" == "linux"* ]]; then
#   echo "Linux was detected ..."
  
#   if ! which apt-get > /dev/null; then
#     echo "install apt-get (debian/ubuntu)"
#     exit 1
#   fi

#   for dep in "${deps[@]}"; do
#     echo -n $(yellow "checking if $dep is installed... ") 
    
#     if ! dpkg-query -l | grep "$dep" > /dev/null; then
#       echo $(error)
#       echo $(green "installing "$dep" ...") 
#       sudo apt-get install -y "$dep"
#     else
#       echo $(success) 
#     fi
#   done
# fi


# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# if [ ! -f "$DIR/.env" ]; then
#     cp "$DIR/.env.example" "$DIR/.env" 
#     echo "copying .env.example to .env"
# fi

# echo $(green "everything is setup!")