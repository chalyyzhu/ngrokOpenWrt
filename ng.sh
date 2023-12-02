#!/data/data/com.termux/files/usr/bin/bash
# Color Validation
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }


HOST="stb.zcoders.me"



function getJsonVal () {
    python3 -c "import json,sys;sys.stdout.write(json.dumps(json.load(sys.stdin)$1, sort_keys=True, indent=4))";
}

ls_apikey(){
  echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e "\E[44;1;39m  ⇱  ngrok apikey  list ⇲     \E[0m"
  echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo "  Name      " 
	echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo ""
  no=0
  cat ~/user.txt | while read line || [[ -n $line ]];
  do  
      no=$(($no+1))
      name=$(echo "$line" | cut -d " " -f 1)
      apikey=$(echo "$line" | cut -d " " -f 2)
      secret=$(echo "$line" | cut -d " " -f 3)
      echo -e "[\e[36m•$no\e[0m] $name" | column -t
  done
  echo ""
  red "tap enter to go back"
  echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
}	
	
get_user(){
  if [ -z $1 ]; then
      menu
  else
      cat ~/user.txt | while read line || [[ -n $line ]];
      do  
          no=$(($no+1))
          if [[ ${no} == $1 ]]; then
              name=$(echo "$line" | cut -d " " -f 1)
              apikey=$(grep -wE "$name" ~/user.txt | cut -d ' ' -f 2 | sort | uniq)
              secret=$(grep -wE "$name" ~/user.txt | cut -d ' ' -f 3 | sort | uniq)
              user="$name $apikey $secret"
              echo $user
          fi
      done
  fi
  
}


del_apikey() {
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "" ~/user.txt)
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\E[44;1;39m     ⇱ Delete ngrok apikey ⇲     \E[0m"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
		echo ""
		echo "You have no existing apikey!"
		echo ""
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
		read -n 1 -s -r -p "Press any key to back on menu"
        menu
	fi

	clear
	echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[44;1;39m     ⇱ Delete ngrok apikey ⇲     \E[0m"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo "  Name     Apikey      " 
	echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    no=0
	cat ~/user.txt | while read line || [[ -n $line ]];
  do  
      no=$(($no+1))
      name=$(echo "$line" | cut -d " " -f 1)
      apikey=$(echo "$line" | cut -d " " -f 2)
      secret=$(echo "$line" | cut -d " " -f 3)
      echo -e "[\e[36m•$no\e[0m] $name $apikey" | column -t
  done
  echo ""
  red "tap enter to go back"
  echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	read -rp "Input name : " name
    if [ -z $name ]; then
        menu
    else
        cat ~/user.txt | while read line || [[ -n $line ]];
        do  
            no=$(($no+1))
            if [[ ${no} == ${name} ]]; then
                name=$(echo "$line" | cut -d " " -f 1)
                apikey=$(grep -wE "$name" ~/user.txt | cut -d ' ' -f 2 | sort | uniq)
                secret=$(grep -wE "$name" ~/user.txt | cut -d ' ' -f 3 | sort | uniq)
                sed -i "/$name $apikey $secret*/d" ~/user.txt
                clear
                echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                echo " Ngrok Apikey Deleted Successfully"
                echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                echo " Name    : $name"
                echo " Apikey  : $apikey"
                echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                echo ""
                sleep 3
                break;
                
            fi
        done
        del_apikey
       
    fi
}

add_apikey() {
    clear
    until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;41;36m         ADD NGROK APIKEY          \E[0m"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    read -rp "Api Key: " -e apikey
    user_EXISTS=$(grep -w $apikey ~/user.txt | wc -l)
    if [[ ${user_EXISTS} == '1' ]]; then
        clear
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\E[0;41;36m       NGROK APIKEY FAILED          \E[0m"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo ""
        echo "A client with the specified apikey was already created, please choose another apikey."
        echo ""
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        read -n 1 -s -r -p "Press any key to back on menu"
        add_apikey
    fi
    read -rp "Name: " -e name
    read -rp "YACD Secret: " -e secret
    echo -e "$name $apikey $secret" >> ~/user.txt
    clear
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[44;1;39m      Add ngrok apikey sucess      \E[0m"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    echo "Name : $name"
    echo "Api Key : $apikey"
    echo "YACD Secret : $secret"
    echo ""
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    sleep 5
    menu
    done
}

open_luci() {
  ls_apikey
  read -rp "Input Number : " num
  user=$(get_user $num)
  name=$(echo "$user" | cut -d " " -f 1)
  API_KEY=$(grep -wE "$name" ~/user.txt | cut -d ' ' -f 2 | sort | uniq)
	req=$(curl -s \
    -X GET \
    -H "Authorization: Bearer $API_KEY" \
    -H "Ngrok-Version: 2" \
    https://api.ngrok.com/tunnels)
  tunel=$(echo $req | grep "tunnels" | wc -l)
  if [[ ${tunel} == '1' ]]; then
      hasil=$(echo $req | jq .tunnels)
      items=$(echo "$hasil" | jq -c -r '.[]') 
      for item in ${items[@]}; do 
        local=$(echo $item | jq --raw-output ".forwards_to")
        if [[ ${local} == 'localhost:80' ]]; then
           url=$(echo $item | jq --raw-output ".public_url")
           local=$(echo $item | jq --raw-output ".forwards_to")
           fp=$(echo $url | cut -d ":" -f 3)
           url="http://$HOST:$fp"
           clear
           echo "Please waitt..."
           termux-open $url
           sleep 10
           menu
        fi
      done
      
  else
     err_msg=$(echo $req | jq .msg)
     err_code=$(echo $req | jq .error_code)
     echo "ERROR CODE : $err_code"
     
     echo $err_msg
     
  fi
  
}

open_yacd() {
  ls_apikey
  read -rp "Input Number : " num
  user=$(get_user $num)
  name=$(echo "$user" | cut -d " " -f 1)
  API_KEY=$(grep -wE "$name" ~/user.txt | cut -d ' ' -f 2 | sort | uniq)
  secret=$(grep -wE "$name" ~/user.txt | cut -d ' ' -f 3 | sort | uniq)
	req=$(curl -s \
    -X GET \
    -H "Authorization: Bearer $API_KEY" \
    -H "Ngrok-Version: 2" \
    https://api.ngrok.com/tunnels)
  tunel=$(echo $req | grep "tunnels" | wc -l)
  if [[ ${tunel} == '1' ]]; then
      hasil=$(echo $req | jq .tunnels)
      items=$(echo "$hasil" | jq -c -r '.[]') 
      for item in ${items[@]}; do 
        local=$(echo $item | jq --raw-output ".forwards_to")
        if [[ ${local} == 'localhost:9090' ]]; then
           url=$(echo $item | jq --raw-output ".public_url")
           local=$(echo $item | jq --raw-output ".forwards_to")
           fp=$(echo $url | cut -d ":" -f 3)
           url="http://$HOST:$fp/ui/yacd/?hostname=$HOST&port=$fp&secret=$secret#"
           clear
           echo "Opening YACD , Please waitt..."
           termux-open $url
           sleep 10
           menu
        fi
      done
      
  else
     err_msg=$(echo $req | jq .msg)
     err_code=$(echo $req | jq .error_code)
     echo "ERROR CODE : $err_code"
     
     echo $err_msg
     
  fi
}

open_terminal(){
  ls_apikey
  read -rp "Input Number : " num
  user=$(get_user $num)
  name=$(echo "$user" | cut -d " " -f 1)
  API_KEY=$(grep -wE "$name" ~/user.txt | cut -d ' ' -f 2 | sort | uniq)
  secret=$(grep -wE "$name" ~/user.txt | cut -d ' ' -f 3 | sort | uniq)
	req=$(curl -s \
    -X GET \
    -H "Authorization: Bearer $API_KEY" \
    -H "Ngrok-Version: 2" \
    https://api.ngrok.com/tunnels)
  tunel=$(echo $req | grep "tunnels" | wc -l)
  if [[ ${tunel} == '1' ]]; then
      hasil=$(echo $req | jq .tunnels)
      items=$(echo "$hasil" | jq -c -r '.[]') 
      for item in ${items[@]}; do 
        local=$(echo $item | jq --raw-output ".forwards_to")
        if [[ ${local} == 'localhost:22' ]]; then
           url=$(echo $item | jq --raw-output ".public_url")
           local=$(echo $item | jq --raw-output ".forwards_to")
           fp=$(echo $url | cut -d ":" -f 3)
           clear
           echo "Connecting to terminal , Please waitt..."
           sshpass -p 'indonesia' ssh -o 'StrictHostKeyChecking accept-new' root@$HOST -p $fp
          
           menu
        fi
      done
      
  else
     err_msg=$(echo $req | jq .msg)
     err_code=$(echo $req | jq .error_code)
     echo "ERROR CODE : $err_code"
     
     echo $err_msg
     
  fi 
}

all_url(){
  ls_apikey
  read -rp "Input Number : " num
  user=$(get_user $num)
  name=$(echo "$user" | cut -d " " -f 1)
  API_KEY=$(grep -wE "$name" ~/user.txt | cut -d ' ' -f 2 | sort | uniq)
  secret=$(grep -wE "$name" ~/user.txt | cut -d ' ' -f 3 | sort | uniq)
	req=$(curl -s \
    -X GET \
    -H "Authorization: Bearer $API_KEY" \
    -H "Ngrok-Version: 2" \
    https://api.ngrok.com/tunnels)
  tunel=$(echo $req | grep "tunnels" | wc -l)
  if [[ ${tunel} == '1' ]]; then
      hasil=$(echo $req | jq .tunnels)
      items=$(echo "$hasil" | jq -c -r '.[]') 
      clear
      echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
      echo -e "\E[44;1;39m  ⇱  ngrok all url  list ⇲     \E[0m"
      echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
      echo "  Host                       From  " 
    	echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
      echo ""
  
      for item in ${items[@]}; do 
        local=$(echo $item | jq --raw-output ".forwards_to")
        url=$(echo $item | jq --raw-output ".public_url")
        p_url=$(echo $url | cut -d ":" -f 3)
        echo "http://$HOST:$p_url  ==>  $local"
      done
      echo ""
      red "tap enter to go back"
      echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
      read -rp "Tap Enter to back menu : "
      menu
      
  else
     err_msg=$(echo $req | jq .msg)
     err_code=$(echo $req | jq .error_code)
     echo "ERROR CODE : $err_code"
     
     echo $err_msg
     
  fi 
}


menu() {
    ISP=$(curl -s ipinfo.io/org?token=8662ae41a84d2c | cut -d " " -f 2-10 )
    DATE=$(date +%m/%d/%Y)
    IPVPS=$(curl -s ipinfo.io/ip?token=8662ae41a84d2c )
    clear 
    echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "           • ZCODERS OPEN-WRT REMOTE •                 "
    echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"	
    echo -e "\e[33m IP            \e[0m:  $IPVPS"	
    echo -e "\e[33m ASN           \e[0m:  $ISP"
    echo -e "\e[33m DATE & TIME   \e[0m:  $DATE"	
    echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "                 • SCRIPT MENU •                 "
    echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    echo -e " [\e[36m•1\e[0m] Luci OpenWRT"
    echo -e " [\e[36m•2\e[0m] Yacd"
    echo -e " [\e[36m•3\e[0m] Terminal"
    echo -e " [\e[36m•4\e[0m] Add api-key"
    echo -e " [\e[36m•5\e[0m] Delete api-key"
    echo -e " [\e[36m•6\e[0m] Show all url"
    echo -e   ""
    echo -e   " Press x or [ Ctrl+C ] • To-Exit-Script"
    echo -e   ""
    echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e   ""
    read -p " Select menu :  "  opt
    echo -e   ""
    case $opt in
    1) clear ; open_luci ;;
    2) clear ; open_yacd ;;
    3) clear ; open_terminal ;;
    4) clear ; add_apikey ;;
    5) clear ; del_apikey ;;
    6) clear ; all_url;;
    x) exit ;;
    *) echo "Anda salah tekan " ; sleep 1 ; menu ;;
    esac
}

menu
