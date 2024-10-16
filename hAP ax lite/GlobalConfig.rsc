:global BotID 2103167656:AAEfFGANTISENDIRIwbVdizhle0dh0;
:global ChatID 10GANTI22;
:global GroupID -100GANTI00;
:global thisbox [/system/identity/get name];

:global ip [/ip/address/get number=2 address];
:set ip [:pick $ip 0 [:find $ip "/"]];

:global GlobalConfig true;
:log warning "GlobalConfig Running";
