#!/usr/bin/env bash

greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

if [[ -n "$1" ]]; then
  named="$1.py"
  if [[ -f "$named" ]]; then
    echo -e "\n\t${yellowColour}[!] The file $named already exists${endColour}"
    read -p "[+] Do you want to replace it? [y/n]: " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
      echo "#!/usr/bin/env python3" > $named
      chmod 755 $named
    else
      echo -e "${redColour}\n\t[!] Exiting...${endColour}"
      exit 1
    fi
  else
    echo "#!/usr/bin/env python3" > $named
    chmod 755 $named
  fi
  echo -e "\n\t${blueColour}[+] The file: $named has been created${endColour}"
else
  echo -e "\n\t${redColour}[!] You have to Write a name${endColour}"
fi
