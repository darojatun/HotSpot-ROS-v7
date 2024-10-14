:global GlobalConfig;
:if ($GlobalConfig != true) do={ /system/script/run GlobalConfig;};
:global BotID;
:global ChatID;
:global thisbox;

#:local volt [/system/health/get number=1 value]
#set volt ($volt . "V");


:local temp [/system/health/get number=0 value]
set temp ($temperature . "%E2%84%83");

:local totalUser [/ip hotspot active print count-only];

/tool fetch url="https://api.telegram.org/bot$BotID/sendMessage?chat_id=$ChatID&parse_mode=Markdown&text=*$thisbox* | %C2%BB *$totalUser* %C2%AB | $temp " keep-result=no;
