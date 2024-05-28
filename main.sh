#!/bin/bash
links=(
    "https://raw.githubusercontent.com/m3hdio1/v2ray_sub/main/v2ray_sub.txt"
    "https://raw.githubusercontent.com/hkpc/V2ray-Configs/main/All_Configs_Sub.txt"
    "https://raw.githubusercontent.com/Epodonios/v2ray-configs/main/All_Configs_Sub.txt"
    "https://raw.githubusercontent.com/peasoft/NoMoreWalls/master/list_raw.txt"
    "https://raw.githubusercontent.com/LalatinaHub/Mineral/master/result/nodes"
    "https://raw.githubusercontent.com/Barabama/FreeNodes/master/nodes/wenode.txt"
    "https://raw.githubusercontent.com/Barabama/FreeNodes/master/nodes/merged.txt"
    "https://raw.githubusercontent.com/Barabama/FreeNodes/master/nodes/kkzui.txt"
    "https://raw.githubusercontent.com/mahdibland/V2RayAggregator/master/sub/sub_merge.txt"
    "https://raw.githubusercontent.com/chengaopan/AutoMergePublicNodes/master/list_raw.txt"
    "https://raw.githubusercontent.com/HakurouKen/free-node/main/public"
    "https://raw.githubusercontent.com/Everyday-VPN/Everyday-VPN/main/subscription/main.txt"
    "https://raw.githubusercontent.com/MrMohebi/xray-proxy-grabber-telegram/master/collected-proxies/row-url/actives.txt"
    "https://raw.githubusercontent.com/barry-far/V2ray-Configs/main/All_Configs_Sub.txt"
    "https://raw.githubusercontent.com/asakura42/vss/master/output.txt"
    "https://raw.githubusercontent.com/MrMohebi/xray-proxy-grabber-telegram/master/collected-proxies/row-url/all.txt"
)

for link in "${links[@]}"; do
    curl -s "$link" >> nodes
    echo "Downloaded $link"
done

best=(
    "https://mangkoyla.vercel.app/api/raw?vpn=vmess,vless,trojan"
)

for best in "${best[@]}"; do
    curl -s "$best" >> best
    echo "Downloaded $best"
done

chmod +x ./main64.sh

bash ./main64.sh

base64 -d nodes64 > base64node

echo "All downloads completed!"

extract_lines() {
    local file="$1"
    grep -E '^.*(vmess|vless|trojan|ss)://' "$file"
}


extract_lines "nodes" >> extracted_nodes
extract_lines "base64node" >> extracted_nodes64

echo "Extraction completed!"

cat extracted_nodes extracted_nodes64 > account

rm -rf All
sort -u account > oke
file="account"
vmess=$(grep -E -o 'vmess://[^[:space:]]+' "$file")
vless=$(grep -E -o 'vless://[^[:space:]]+' "$file")
trojan=$(grep -E -o 'trojan://[^[:space:]]+' "$file")
ss=$(grep -E -o 'ss://[^[:space:]]+' "$file")

echo "$vmess" > vmess1
echo "$vless" > vless1
echo "$trojan" > trojan1
echo "$ss" > ss1

sort -u vmess1 > vmess
sort -u vless1 > vless
sort -u trojan1 > trojan
sort -u ss1 > ss

#### speed test command ####
#chmod +x ./bin/xrayknife
#rm -rf valid.txt
#./bin/xrayknife net http -f best
#sort -u valid.txt > Best-ping
