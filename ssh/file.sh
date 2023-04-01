#!/bin/bash
# Script By Tarap Kuhing
# 2022 SLOWDNS
# ===============================================
fun_bar 'ipt_set'
clear
echo ""
echo -e "\033[1;31m ATTENTION IN THIS STAGE! \033[1;33m"
echo ""
echo -ne "\033[1;32m ENTER YOUR NS (NAMESERVER)\033[1;37m: "; read nameserver
#nameserver=`cat /root/nsdomain`
cd /etc/slowdns
touch infons
echo $nameserver > infons
set_ns () {
sleep 1
#sl-fix
cd /usr/bin
wget -O sl-fix "https://raw.githubusercontent.com/Farukbrowser/24clanSSHPro/main/sl-fix"
chmod +x sl-fix
sl-fix
}
fun_bar 'set_ns'
echo ""
echo "Checking for existence of key"
sleep 2
echo ""
echo "      Please wait...   "
sleep 2
cd
key1="/root/server.key"
key2="/root/server.pub"
if [ -f $key1 ] && [ -f $key2 ]
then
echo -e "Key file found!"
sleep 1
echo ""
key () {
echo "How do you want to get your key?"
echo ""
echo "[ 1 ] | Use existing key in file"
echo "[ 2 ] | Delete file and generate new key"
echo "[ 3 ] | Delete file and use default key"
echo "[ x ] | Abort installation"
echo ""
echo -ne "Enter an option: " && read option
case $option in
1) Option1 ;;
2) Option2 ;;
3) Option3 ;;
x) OptionX ;;
*) "Unknown command" ; echo ; key;;
esac
}
Option1 () {
echo -ne "Restoring existing key..." && sleep 2 && echo "OK!"
echo ""
echo -e "FINISHING..."
finish_ist () {
cd /etc/slowdns
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns
}
fun_bar 'finish_ist'
clear
echo -e "\033[1;31m INSTALLATION COMPLETED!\033[0m"
echo ""
echo -ne "\033[1;33mYOUR NS:\033[0m " && cat /etc/slowdns/infons
echo ""
echo -ne "\033[1;33mYOUR PUBLIC KEY:\033[0m " && cat /root/server.pub
echo ""
echo -ne "\033[1;33mTERMUX COMMAND:\033[0m curl -sO https://github.com/Farukbrowser/Slowdns/raw/main/files/slowdns && chmod +x slowdns && ./slowdns " && cat /etc/slowdns/infons /root/server.pub
echo ""
echo -e "\033[1;33m YOUR KEY is saved in the file /root/server.pub\033[0m"
echo -e "\033[1;33mKeep it in a safe place, you may need it in the future!\033[0m"
echo ""
read -p "Press [Enter] to return to the menu or CTRL+C to exit"
menu
}
Option2 () {
cd
rm server.key server.pub
echo "Generating new key"
cd /etc/slowdns/
./dns-server -gen-key -privkey-file /root/server.key -pubkey-file /root/server.pub
echo -e "FINISHING..."
finish_ist () {
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns
cd
}
fun_bar 'finish_ist'
clear
echo -e "\033[1;31m INSTALLATION COMPLETED!\033[0m"
echo ""
echo -ne "\033[1;33mYOUR NS:\033[0m " && cat /etc/slowdns/infons
echo ""
echo -ne "\033[1;33mYOUR PUBLIC KEY:\033[0m " && cat /root/server.pub
echo ""
echo -ne "\033[1;33mTERMUX COMMAND:\033[0m curl -sO https://github.com/Farukbrowser/Slowdns/raw/main/files/slowdns && chmod +x slowdns && ./slowdns " && cat /etc/slowdns/infons /root/server.pub
echo ""
echo -e "\033[1;33m YOUR KEY is saved in the file /root/server.pub\033[0m"
echo -e "\033[1;33mKeep it in a safe place, you may need it in the future!\033[0m"
echo ""
read -p "Press [Enter] to return to the menu or CTRL+C to exit"
menu
}
Option3 () {
echo -e "Downloading default key pair..."
cd
rm server.key server.pub
wget https://raw.githubusercontent.com/Farukbrowser/SLDNS/main/slowdns/server.key
wget https://raw.githubusercontent.com/Farukbrowser/SLDNS/main/slowdns/server.pub
sleep 1
echo -e "Download Completed"
sleep 1
cd /etc/slowdns/
echo -e "FINISHING..."
finish_ist () {
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns
cd
}
fun_bar 'finish_ist'
clear
echo -e "\033[1;31m INSTALLATION COMPLETED!\033[0m"
echo ""
echo -ne "\033[1;33mYOUR NS:\033[0m " && cat /etc/slowdns/infons
echo ""
echo -ne "\033[1;33mSUA KEY:\033[0m " && cat /root/server.pub
echo ""
echo -ne "\033[1;33mTERMUX COMMAND:\033[0m curl -sO https://github.com/Farukbrowser/Slowdns/raw/main/files/slowdns && chmod +x slowdns && ./slowdns " && cat /etc/slowdns/infons /root/server.pub
echo ""
echo -e "\033[1;33m YOUR KEY is saved in the file /root/server.pub\033[0m"
echo -e "\033[1;33mKeep it in a safe place, you may need it in the future!\033[0m"
echo ""
read -p "Press [Enter] to return to the menu or CTRL+C to exit"
menu
}
OptionX () {
exit
}
key
else
echo -e "There is no key in the logs"
echo ""
key_gen () {
echo "How do you want to get your key?"
echo ""
echo "[ 1 ] | Generate on installation"
echo "[ 2 ] | Use the default key"
echo "[ x ] | Abort installation"
echo ""
echo -ne "Enter an option: " && read opc_key
case $opc_key in
1) opc_key1 ;;
2) opc_key2 ;;
x) opc_keyx ;;
*) "Unknown command" ; echo ; key_gen;;
esac
}
opc_key1 () {
echo "Generating your key..."
cd /etc/slowdns/
./dns-server -gen-key -privkey-file /root/server.key -pubkey-file /root/server.pub
echo -e "FINISHING..."
finish_ist () {
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns
cd
}
fun_bar 'finish_ist'
clear
echo -e "\033[1;31m INSTALLATION COMPLETED!\033[0m"
echo ""
echo -ne "\033[1;33mYOUR NS:\033[0m " && cat /etc/slowdns/infons
echo ""
echo -ne "\033[1;33mYOUR PUBLIC KEY:\033[0m " && cat /root/server.pub
echo ""
echo -ne "\033[1;33mTERMUX COMMAND:\033[0m curl -sO https://github.com/Farukbrowser/Slowdns/raw/main/files/slowdns && chmod +x slowdns && ./slowdns " && cat /etc/slowdns/infons /root/server.pub
echo ""
echo -e "\033[1;33m YOUR KEY is saved in the file /root/server.pub\033[0m"
echo -e "\033[1;33mKeep it in a safe place, you may need it in the future!\033[0m"
echo ""
read -p "Press [Enter] to return to the menu or CTRL+C to exit"
slowdns
}
opc_key2 () {
echo -e "Downloading default key pair..."
cd
wget https://raw.githubusercontent.com/Farukbrowser/SLDNS/main/slowdns/server.key
wget https://raw.githubusercontent.com/Farukbrowser/SLDNS/main/slowdns/server.pub
sleep 1
echo -e "Download Completed"
sleep 1
cd /etc/slowdns/
echo -e "FINISHING..."
finish_ist () {
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns
cd
}
fun_bar 'finish_ist'
clear
echo -e "\033[1;31m INSTALLATION COMPLETED!\033[0m"
echo ""
echo -ne "\033[1;33mYOUR NS:\033[0m " && cat /etc/slowdns/infons
echo ""
echo -ne "\033[1;33mYOUR PUBLIC KEY:\033[0m " && cat /root/server.pub
echo ""
echo -ne "\033[1;33mTERMUX COMMAND:\033[0m curl -sO https://github.com/Farukbrowser/Slowdns/raw/main/files/slowdns && chmod +x slowdns && ./slowdns " && cat /etc/slowdns/infons /root/server.pub
echo ""
echo -e "\033[1;33m YOUR KEY is saved in the file /root/server.pub\033[0m"
echo -e "\033[1;33mKeep it in a safe place, you may need it in the future!\033[0m"
echo ""
read -p "Press [Enter] to return to the menu or CTRL+C to exit"
slowdns
}
opc_keyx () {
echo "Aborting installation"
sleep 2
menu
}
key_gen
fi
