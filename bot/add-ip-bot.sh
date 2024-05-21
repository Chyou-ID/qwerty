url_izin="https://raw.githubusercontent.com/oktaviaps/permission/main/ip"
IP=$(curl -sS ipv4.icanhazip.com)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
checking_sc() {
    useexp=$(wget -qO- $url_izin | grep $IP | awk '{print $3}')
    if [[ $date_list < $useexp ]]; then
        echo -ne
    else
        echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
        echo -e "\033[42m          404 NOT FOUND AUTOSCRIPT          \033[0m"
        echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
        echo -e ""
        echo -e "            ${RED}PERMISSION DENIED !${NC}"
        echo -e "   \033[0;33mYour VPS${NC} $IP \033[0;33mHas been Banned${NC}"
        echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
        echo -e "             \033[0;33mContact Admin :${NC}"
        echo -e "      \033[0;36mWhatsapp${NC} wa.me/6281228861758"
        echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
        exit
    fi
}
checking_sc

clear
echo -e ""
read -p "Input IP Address : " ip
CLIENT_EXISTS=$(curl -sS https://anggaalfa.my.id/izin/ip | grep -w $ip | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
    echo "IP Already Exist !"
    exit 0
fi
name=SFVT-`</dev/urandom tr -dc A-Z0-9 | head -c4`
clear
read -p " Masukan waktu expired : " -e exp
exp2=`date -d "${exp} days" +"%Y-%m-%d"`

# Prepare data to be sent
data="### ${name} ${exp2} ${ip}"

# Send data to hosting using HTTP POST
curl -X POST -d "data=${data}" https://anggaalfa.my.id/izin/ip --silent --insecure > /dev/null

clear
