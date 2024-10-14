:global GlobalConfig;
:if ($GlobalConfig != true) do={ /system/script/run GlobalConfig;};
:global BotID;
:global ChatID;
:global thisbox;

:local uptime [/system resource get uptime];
# ganti nama interface yang dipantau,  brp FUP max, BotID dan ChatID
:local INTMon 1-WAN;

:local RXByteCur [/interface get $INTMon rx-byte]; 
:local TXByteCur [/interface get $INTMon tx-byte];  

:local RXTot ($RXByte+$RXByteCur);  
 :local RXMB ($RXTot / 1024 / 1024);  
 :local RXGB ($RXTot / 1024 / 1024 / 1024);  
 # kalkulasi nilai RX-BYTE dalam MB dan GB  
 ################################################################  
 :local TXTot ($TXByte+$TXByteCur);  
 :local TXMB ($TXTot / 1024 / 1024);  
 :local TXGB ($TXTot / 1024 / 1024 / 1024);  
 # kalkulasi nilai TX-BYTE dalam MB dan GB  
 ################################################################  
 :local RXTX ($RXTot+$TXTot);  
 :local RXTXMB ($RXMB+$TXMB);  
 :local RXTXGB ($RXGB+$TXGB);  
 # Total kalkulasi nilai Total RXTX  

/tool fetch url="https://api.telegram.org/bot$BotID/sendMessage?chat_id=$ChatID&parse_mode=Markdown&text=*$thisbox* | Usage %C2%BB *$RXTXGB* %C2%AB in Gb | Uptime $uptime" keep-result=no;

 :local varDate [/system clock get date];  
 :local varDay [:pick $varDate 4 6];  
 :if ($varDay = "01") do={
 /interface reset-counters $INTMon;  
 }
