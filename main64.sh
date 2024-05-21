links64=(
    "https://raw.githubusercontent.com/Leon406/SubCrawler/main/sub/share/vless"
    "https://raw.githubusercontent.com/mangkoyla/v2ray/master/v2ray"
    "https://hueco.link/v.txt"
    "https://raw.githubusercontent.com/ts-sf/fly/main/v2"
    "https://github.com/Vauth/node/raw/main/Main"
    "https://github.com/Vauth/node/raw/main/Master"
    "https://raw.githubusercontent.com/firefoxmmx2/v2rayshare_subcription/main/subscription/vray_sub.txt"
    "https://raw.githubusercontent.com/0x24a/FreeNodes/main/subs/main.txt"
    "https://raw.githubusercontent.com/Surfboardv2ray/TGParse/main/splitted/mixed"
    "https://raw.githubusercontent.com/mheidari98/.proxy/main/all"
    "https://raw.githubusercontent.com/soroushmirzaei/telegram-configs-collector/main/splitted/mixed"
)

for link64 in "${links64[@]}"; do
    curl -s "$link64" >> nodes64
    echo "Downloaded $link64"
done
sed -i 's/^vmess:\/\/\|vless:\/\/\|trojan:\/\/\|ss:\/\///g' nodes64
