#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/tarap/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/tarap/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/tarap/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
###########- END COLOR CODE -##########

BURIQ () {
    curl -sS https://raw.githubusercontent.com/Farukbrowser/Profile/main/Profile/permission/ip > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/Farukbrowser/Profile/main/Profile/permission/ip | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/Farukbrowser/Profile/main/Profile/permission/ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi
clear
tls="$(cat ~/log-install.txt | grep -w "Vless WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless WS none TLS" | cut -d: -f2|sed 's/ //g')"
NUMBER_OF_CLIENTS=$(grep -c -E "^#vls " "/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY VLESS WS"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#vls " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
export user=$(grep -E "^#vls " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
export harini=$(grep -E "^#vls " /etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
export exp=$(grep -E "^#vls " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
export uuid=$(grep -E "^#vls " "/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)

export vlesslink1="vless://${uuid}@${sts}${domain}:$tls?path=$patchtls&security=tls&encryption=none&type=ws&sni=$sni#${user}"
export vlesslink2="vless://${uuid}@${sts}${domain}:$none?path=$patchnontls&encryption=none&host=$sni&type=ws#${user}"
export vlesslink3="vless://${uuid}@${domain}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=$sni#${user}"

clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${COLBG1}           ${WH}• CREATE VLESS USER •               ${NC} $COLOR1 $NC" | tee -a /etc/log-create-user.log
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} "
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${WH}Remarks      ${COLOR1}: ${WH}${user}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Domain       ${COLOR1}: ${WH}${domain}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Wildcard     ${COLOR1}: ${WH}(bug.com).${domain}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Port TLS     ${COLOR1}: ${WH}$tls" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Port none TLS${COLOR1}: ${WH}80,8080" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}id           ${COLOR1}: ${WH}${uuid}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Encryption   ${COLOR1}: ${WH}none" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Network      ${COLOR1}: ${WH}ws" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Path         ${COLOR1}: ${WH}/vless" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Path         ${COLOR1}: ${WH}vless-grpc" | tee -a /etc/log-create-user.log
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} "
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLOR1}Link Websocket TLS      ${WH}:${NC}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}${vlesslink1}${NC}"  | tee -a /etc/log-create-user.log
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLOR1}Link Websocket non TLS  ${WH}:${NC}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}${vlesslink2}${NC}"  | tee -a /etc/log-create-user.log
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLOR1}Link gRPC               ${WH}:${NC}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}${vlesslink3}${NC}"  | tee -a /etc/log-create-user.log
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${WH}Expired On   ${COLOR1}: ${WH}$exp" | tee -a /etc/log-create-user.log
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1┌────────────────────── ${WH}BY${NC} ${COLOR1}───────────────────────┐${NC}"
echo -e "$COLOR1 ${NC}                ${WH}• FARUK BROWSER •${NC}                 $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi