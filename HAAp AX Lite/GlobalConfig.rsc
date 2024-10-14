:global BotID 2103167656:AAEfF6AT9888888888VJwbVdizhle0dh0;
:global ChatID 106GGGGGG822;
:global thisbox [/system/identity/get name];

:global ip [/ip/address/get number=2 address];
:set ip [:pick $ip 0 [:find $ip "/"]];

:global GlobalConfig true;
:log warning "GlobalConfig Running";
