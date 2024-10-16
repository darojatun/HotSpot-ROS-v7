# 2024-10-16 21:23:05 by RouterOS 7.16.1
# software id = MIJJ-RMW4
#
# model = L41G-2axD
# serial number = HE708VT75CZ
/interface bridge
add name=HotSpot port-cost-mode=short
add name=WAN port-cost-mode=short
/interface ethernet
set [ find default-name=ether1 ] name=1-WAN
set [ find default-name=ether2 ] name=2-HotSpot
set [ find default-name=ether3 ] name=3-HotSpot
set [ find default-name=ether4 ] name=4-HotSpot
/interface wifi
set [ find default-name=wifi1 ] configuration.mode=ap .ssid=HotSpot disabled=\
    no
/ip hotspot user profile
add name=Trial rate-limit=5M
add name=Family rate-limit=3M shared-users=2
add name=Guest rate-limit=2M shared-users=3
/ip hotspot profile
add dns-name=wifi-hotspot.id hotspot-address=192.168.176.10 login-by=\
    cookie,http-chap,http-pap,trial,mac-cookie name=hsprof1 \
    trial-uptime-limit=3m trial-user-profile=Trial use-radius=yes
/ip pool
add name=dhcp_pool1 ranges=192.168.176.11-192.168.177.254
/ip dhcp-server
add add-arp=yes address-pool=dhcp_pool1 interface=HotSpot lease-time=1d name=\
    dhcp1
/ip hotspot
add address-pool=dhcp_pool1 disabled=no interface=HotSpot name=hotspot1 \
    profile=hsprof1
/port
set 0 name=serial0
/user-manager limitation
add name="4 Jam" rate-limit-burst-rx=5000000B rate-limit-burst-threshold-rx=\
    2000000B rate-limit-burst-threshold-tx=2000000B rate-limit-burst-time-rx=\
    5s rate-limit-burst-time-tx=5s rate-limit-burst-tx=5000000B \
    rate-limit-min-rx=1000000B rate-limit-min-tx=1000000B \
    rate-limit-priority=1 rate-limit-rx=3000000B rate-limit-tx=3000000B \
    uptime-limit=4h
add download-limit=1000000000B name=24Jam rate-limit-burst-rx=3000000B \
    rate-limit-burst-threshold-rx=1000000B rate-limit-burst-threshold-tx=\
    1000000B rate-limit-burst-time-rx=3s rate-limit-burst-time-tx=3s \
    rate-limit-burst-tx=3000000B rate-limit-min-rx=512000B rate-limit-min-tx=\
    512000B rate-limit-priority=2 rate-limit-rx=2000000B rate-limit-tx=\
    2000000B transfer-limit=2000000000B upload-limit=1000000000B \
    uptime-limit=1d
/user-manager profile
add name="4 Jam" name-for-users="4 Jam" price=5000 starts-when=first-auth \
    validity=4h
add name=24Jam name-for-users=24Jam price=10000 starts-when=first-auth \
    validity=1d
/interface bridge port
add bridge=WAN interface=1-WAN internal-path-cost=10 path-cost=10
add bridge=HotSpot interface=2-HotSpot internal-path-cost=10 path-cost=10
add bridge=HotSpot interface=3-HotSpot internal-path-cost=10 path-cost=10
add bridge=HotSpot interface=4-HotSpot internal-path-cost=10 path-cost=10
add bridge=HotSpot interface=wifi1 internal-path-cost=10 path-cost=10
/ip firewall connection tracking
set udp-timeout=10s
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/ip address
add address=192.168.176.10/23 interface=HotSpot network=192.168.176.0
add address=192.168.10.10/24 interface=WAN network=192.168.10.0
/ip dhcp-client
add interface=WAN
/ip dhcp-server network
add address=192.168.176.0/23 dns-server=192.168.176.10 gateway=192.168.176.10 \
    ntp-server=192.168.176.10
/ip dns
set allow-remote-requests=yes
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
/ip firewall mangle
add action=change-ttl chain=postrouting new-ttl=set:1 out-interface=HotSpot \
    passthrough=no
add action=change-ttl chain=output new-ttl=set:1 out-interface=HotSpot \
    passthrough=no
add action=change-ttl chain=forward new-ttl=set:1 out-interface=HotSpot \
    passthrough=no
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat
/ip hotspot ip-binding
add address=192.168.176.10 type=bypassed
/ip hotspot user
add name=DjCAdmin
add name=G@qa4of profile=Guest
/ip hotspot walled-garden
add comment="place hotspot rules here" disabled=yes
add dst-host=djatun.com
add disabled=yes dst-host=darojatun.github.io
/ip ipsec profile
set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/radius
add address=192.168.10.10 service=hotspot
/radius incoming
set accept=yes
/system clock
set time-zone-name=Asia/Jakarta
/system identity
set name=HotSpot
/system note
set show-at-login=no
/system ntp client
set enabled=yes
/system ntp server
set enabled=yes
/system ntp client servers
add address=jam.bmkg.go.id
/system routerboard mode-button
set enabled=yes on-event=CetakVoucher24JamQR
/system routerboard reset-button
set enabled=yes on-event=CetakVoucher4JamQR
/system scheduler
add interval=1h name=InfoHotSpot on-event=InfoHotSpot policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2024-10-13 start-time=15:58:22
add interval=1d name=Usage on-event=Usage policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2024-10-13 start-time=00:01:15
add interval=2h name=RandomPassword on-event=RandomPassword policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2024-10-13 start-time=16:00:19
/system script
add dont-require-permissions=no name=GlobalConfig owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    global BotID 2103167656:AAEfF6AT9EWK-AinJGoZVJwbVdizhle0dh0;\r\
    \n:global ChatID 1061921822;\r\
    \n:global GroupID -100000000;\r\
    \n:global thisbox [/system/identity/get name];\r\
    \n\r\
    \n:global ip [/ip/address/get number=2 address];\r\
    \n:set ip [:pick \$ip 0 [:find \$ip \"/\"]];\r\
    \n\r\
    \n:global GlobalConfig true;\r\
    \n:log warning \"GlobalConfig Running\";"
add dont-require-permissions=no name=Usage owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    global GlobalConfig;\r\
    \n:if (\$GlobalConfig != true) do={ /system/script/run GlobalConfig;};\r\
    \n:global BotID;\r\
    \n:global ChatID;\r\
    \n:global thisbox;\r\
    \n\r\
    \n:local uptime [/system resource get uptime];\r\
    \n# ganti nama interface yang dipantau,  brp FUP max, BotID dan ChatID\r\
    \n:local INTMon 1-WAN;\r\
    \n\r\
    \n:local RXByteCur [/interface get \$INTMon rx-byte]; \r\
    \n:local TXByteCur [/interface get \$INTMon tx-byte];  \r\
    \n\r\
    \n:local RXTot (\$RXByte+\$RXByteCur);  \r\
    \n :local RXMB (\$RXTot / 1024 / 1024);  \r\
    \n :local RXGB (\$RXTot / 1024 / 1024 / 1024);  \r\
    \n # kalkulasi nilai RX-BYTE dalam MB dan GB  \r\
    \n ################################################################  \r\
    \n :local TXTot (\$TXByte+\$TXByteCur);  \r\
    \n :local TXMB (\$TXTot / 1024 / 1024);  \r\
    \n :local TXGB (\$TXTot / 1024 / 1024 / 1024);  \r\
    \n # kalkulasi nilai TX-BYTE dalam MB dan GB  \r\
    \n ################################################################  \r\
    \n :local RXTX (\$RXTot+\$TXTot);  \r\
    \n :local RXTXMB (\$RXMB+\$TXMB);  \r\
    \n :local RXTXGB (\$RXGB+\$TXGB);  \r\
    \n # Total kalkulasi nilai Total RXTX  \r\
    \n\r\
    \n/tool fetch url=\"https://api.telegram.org/bot\$BotID/sendMessage\?chat_\
    id=\$ChatID&parse_mode=Markdown&text=*\$thisbox* | Usage %C2%BB *\$RXTXGB*\
    \_%C2%AB in Gb | Uptime \$uptime\" keep-result=no;\r\
    \n\r\
    \n :local varDate [/system clock get date];  \r\
    \n :local varDay [:pick \$varDate 4 6];  \r\
    \n :if (\$varDay = \"01\") do={\r\
    \n /interface reset-counters \$INTMon;  \r\
    \n }\r\
    \n"
add dont-require-permissions=no name=CetakVoucher24JamQR owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    global GlobalConfig;\r\
    \n:if (\$GlobalConfig != true) do={ /system/script/run GlobalConfig;};\r\
    \n:global BotID;\r\
    \n:global ChatID;\r\
    \n:global GroupID;\r\
    \n:global thisbox;\r\
    \n:global ip;\r\
    \n\r\
    \n:local Profile \"24 Jam\";\r\
    \n:local PrefixGroup \"1h@\";\r\
    \n:local Quantity 1008;\r\
    \n:local Length 4;\r\
    \n:local Prefix \"2\";\r\
    \n:local Combine \"lowercase,numbers\";\r\
    \n:local PasswordLength empty;\r\
    \n:local Template 24jqr.html;\r\
    \n:local Expiredin 60d;\r\
    \n\r\
    \n:local datetime ([/system/clock/get date] . \"~\" .  [/system/clock/get \
    time]);\r\
    \n\r\
    \n\r\
    \n:local URL (\"http://\" . \$ip .\"/um/PRIVATE/GENERATED/vouchers/gen_\" \
    . \$Template);\r\
    \n:local groupname (\"\$PrefixGroup\$datetime\");\r\
    \n:local srcpath (\"um5files/PRIVATE/GENERATED/vouchers/gen_\" . \$Templat\
    e);\r\
    \n/user-manager/user/group/add name=\$groupname copy-from=0;\r\
    \n/user-manager/user/add-batch-users profile=\$Profile group=\$groupname u\
    sername-length=\$Length username-characters=\$Combine number-of-users=\$Qu\
    antity password-length=\$PasswordLength username-prefix=\$Prefix;\r\
    \n\r\
    \n/user-manager/user/generate-voucher numbers=[find group=\$groupname] vou\
    cher-template=\$Template;\r\
    \n\r\
    \n/system/script/add name=\$groupname source=\\\r\
    \n\"/user-manager/user/remove [find group=\$groupname];\\n\\\r\
    \n/user-manager/user/group/remove [find name=\$groupname];\\n\\\r\
    \n/system/script/run CleaningUM;\\n\\\r\
    \n/system/scheduler/remove [find name=\$groupname];\\n\\\r\
    \n:do { /system/script/remove [find name=\$groupname]}  on-error={};\";\r\
    \n\r\
    \n/system/scheduler/add name=\$groupname interval=\$Expiredin on-event=\$g\
    roupname;\r\
    \n\r\
    \n:log warning (\"New Voucher Generated: \$URL\");\r\
    \n\r\
    \n/tool/fetch url=\"https://api.telegram.org/bot\$BotID/sendMessage\?chat_\
    id=\$ChatID&text=Voucher%20\$thisbox:%20\$URL\" keep-result=no;"
add dont-require-permissions=no name=CetakVoucher4JamQR owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    global GlobalConfig;\r\
    \n:if (\$GlobalConfig != true) do={ /system/script/run GlobalConfig;};\r\
    \n:global BotID;\r\
    \n:global ChatID;\r\
    \n:global thisbox;\r\
    \n:global ip;\r\
    \n\r\
    \n:local Profile \"4 Jam\";\r\
    \n:local PrefixGroup \"4j@\";\r\
    \n:local Quantity 1008;\r\
    \n:local Length 4;\r\
    \n:local Prefix \"4\";\r\
    \n:local Combine \"lowercase,numbers\";\r\
    \n:local PasswordLength empty;\r\
    \n:local Template 4jqr.html;\r\
    \n:local Expiredin 90d;\r\
    \n\r\
    \n:local datetime ([/system/clock/get date] . \"~\" .  [/system/clock/get \
    time]);\r\
    \n\r\
    \n\r\
    \n:local URL (\"http://\" . \$ip .\"/um/PRIVATE/GENERATED/vouchers/gen_\" \
    . \$Template);\r\
    \n:local groupname (\"\$PrefixGroup\$datetime\");\r\
    \n:local srcpath (\"um5files/PRIVATE/GENERATED/vouchers/gen_\" . \$Templat\
    e);\r\
    \n/user-manager/user/group/add name=\$groupname copy-from=0;\r\
    \n/user-manager/user/add-batch-users profile=\$Profile group=\$groupname u\
    sername-length=\$Length username-characters=\$Combine number-of-users=\$Qu\
    antity password-length=\$PasswordLength username-prefix=\$Prefix;\r\
    \n\r\
    \n/user-manager/user/generate-voucher numbers=[find group=\$groupname] vou\
    cher-template=\$Template;\r\
    \n\r\
    \n/system/script/add name=\$groupname source=\\\r\
    \n\"/user-manager/user/remove [find group=\$groupname];\\n\\\r\
    \n/user-manager/user/group/remove [find name=\$groupname];\\n\\\r\
    \n/system/script/run CleaningUM;\\n\\\r\
    \n/system/scheduler/remove [find name=\$groupname];\\n\\\r\
    \n:do { /system/script/remove [find name=\$groupname]}  on-error={};\";\r\
    \n\r\
    \n/system/scheduler/add name=\$groupname interval=\$Expiredin on-event=\$g\
    roupname;\r\
    \n\r\
    \n:log warning (\"New Voucher Generated: \$URL\");\r\
    \n\r\
    \n/tool/fetch url=\"https://api.telegram.org/bot\$BotID/sendMessage\?chat_\
    id=\$ChatID&text=Voucher%20\$thisbox:%20\$URL\" keep-result=yes;"
add dont-require-permissions=no name=InfoHotSpot owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    global GlobalConfig;\r\
    \n:if (\$GlobalConfig != true) do={ /system/script/run GlobalConfig;};\r\
    \n:global BotID;\r\
    \n:global ChatID;\r\
    \n:global thisbox;\r\
    \n\r\
    \n:local temperature [/system/health/get number=0 value]\r\
    \n:local temp (\$temperature . \"%E2%84%83\");\r\
    \n\r\
    \n:local totalUser [/ip hotspot active print count-only];\r\
    \n\r\
    \n/tool fetch url=\"https://api.telegram.org/bot\$BotID/sendMessage\?chat_\
    id=\$ChatID&parse_mode=Markdown&text=*\$thisbox* | %C2%BB *\$totalUser* %C\
    2%AB | \$temp \" keep-result=no;"
add dont-require-permissions=no name=RandomPassword owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    global GlobalConfig;\r\
    \n:if (\$GlobalConfig != true) do={ /system/script/run GlobalConfig;};\r\
    \n:global BotID;\r\
    \n:global ChatID;\r\
    \n:global thisbox;\r\
    \n\r\
    \n:local pwdLength (5);\r\
    \n:local GuestProfile (\"Guest\");\r\
    \n:local PasswordPrefix (\"G@\");\r\
    \n\r\
    \n:local RandomString [:rndstr length=\$pwdLength from=\"0123456789abcdefg\
    hijkmnopqrstuvwxyz\"]\r\
    \n:local password (\"\");\r\
    \n:set password (\$PasswordPrefix . \$RandomString);\r\
    \n:log warning (\"New Random  Password for \$GuestProfile  \$password\");\
    \r\
    \n:global thisbox [/system identity get name];\r\
    \n:local hotspotip [/ip/hotspot/get number=0 ip-of-dns-name];\r\
    \n:local urlqr (\"\");\r\
    \n:set urlqr (\"https%3A%2F%2Fdjatun.com%2Fqr%2F%3Fgen%3Dhttp%3A%2F%2F\$ho\
    tspotip%2Flogin%3Fusername%3D\" . \$password);\r\
    \n\r\
    \n/tool fetch url=\"https://api.telegram.org/bot\$BotID/sendMessage\?chat_\
    id=\$ChatID&parse_mode=Markdown&text=*\$thisbox* _update_ Password WiFi %C\
    2%BB `\$password` %C2%AB \$urlqr\" keep-result=no;\r\
    \n/ip hotspot user remove [find profile=\$GuestProfile];\r\
    \n/ip hotspot user add name=\$password password=\"\" profile=\$GuestProfil\
    e;\r\
    \n"
add dont-require-permissions=no name=CleaningUM owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/\
    user-manager/user-profile/remove [find where user~\"^\\\\*[0-9a-fA-F]{1,8}\
    \\\$\"];\r\
    \n:log info \"User-profile \\\"unknown\\\" removed\";"
/user-manager
set certificate=*0 enabled=yes use-profiles=yes
/user-manager advanced
set web-private-username=voucher
/user-manager profile-limitation
add limitation="4 Jam" profile="4 Jam"
add limitation=24Jam profile=24Jam
/user-manager router
add address=192.168.10.10 name=HotSpot
