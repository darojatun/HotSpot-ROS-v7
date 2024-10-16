:global GlobalConfig;
:if ($GlobalConfig != true) do={ /system/script/run GlobalConfig;};
:global BotID;
:global ChatID;
:global GroupID;
:global thisbox;
:global ip;

:local Profile "24Jam";
:local PrefixGroup "24@";
:local Quantity 1008;
:local Length 4;
:local Prefix "2";
:local Combine "lowercase,numbers";
:local PasswordLength empty;
:local Template 24jqr.html;
:local Expiredin 60d;

:local datetime ([/system/clock/get date] . "~" .  [/system/clock/get time]);


:local URL ("http://" . $ip ."/um/PRIVATE/GENERATED/vouchers/gen_" . $Template);
:local groupname ("$PrefixGroup$datetime");
:local srcpath ("um5files/PRIVATE/GENERATED/vouchers/gen_" . $Template);
/user-manager/user/group/add name=$groupname copy-from=0;
/user-manager/user/add-batch-users profile=$Profile group=$groupname username-length=$Length username-characters=$Combine number-of-users=$Quantity password-length=$PasswordLength username-prefix=$Prefix;

/user-manager/user/generate-voucher numbers=[find group=$groupname] voucher-template=$Template;

/system/script/add name=$groupname source=\
"/user-manager/user/remove [find group=$groupname];\n\
/user-manager/user/group/remove [find name=$groupname];\n\
/system/script/run CleaningUM;\n\
/system/scheduler/remove [find name=$groupname];\n\
:do { /system/script/remove [find name=$groupname]}  on-error={};";

/system/scheduler/add name=$groupname interval=$Expiredin on-event=$groupname;

:log warning ("New Voucher Generated: $URL");

/tool/fetch url="https://api.telegram.org/bot$BotID/sendMessage?chat_id=$ChatID&text=Voucher%20$thisbox:%20$URL" keep-result=no;
