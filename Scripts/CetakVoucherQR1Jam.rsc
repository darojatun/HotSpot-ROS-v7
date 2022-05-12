:local Profile "1 Jam";
:local PrefixGroup "1h@";
:local BotID **************:AA*****************izhle0dh0;
:local ChatID 106*******;
:local FTPServer 103.2*4.**.**;
:local FTPUsername "nkp*****";
:local FTPPassword "jkB******nf228";
:local FTPPath "/public_html/voucher/";
:local URL "https://endang.net/voucher/";
:local Quantity 126;
:local Length 6;
:local PasswordLength empty;
:local Template 1hqr.html;

:global replaceChar do={
  :for i from=0 to=([:len $1] - 1) do={
    :local char [:pick $1 $i]
    :if ($char = $2) do={
      :set $char $3
    }
    :set $output ($output . $char)
  }
  :return $output
}

:local datetime ([/system clock get date] . "~" .  [/system clock get time]);

:local groupname ($PrefixGroup . [$replaceChar $datetime "/" "-"]);
:local srcpath ("um5files/PRIVATE/GENERATED/vouchers/gen_" . $Template);
/user-manager/user/group/add name=$groupname copy-from=0;
/user-manager/user/add-batch-users profile=$Profile group=$groupname username-length=$Length username-characters=lowercase,numbers,uppercase number-of-users=$Quantity password-length=$PasswordLength;

:local filename ($groupname . ".html");
:local dstpath ($FTPPath . $filename);
/user-manager/user/generate-voucher numbers=[find group=$groupname] voucher-template=$Template;

:log warning ("New Voucher Generated: ftp://" . $FTPServer . $dstpath);

/tool fetch address=$FTPServer src-path=$srcpath user=$FTPUsername mode=ftp password=$FTPPassword dst-path=$dstpath port=21 upload=yes keep-result=no;

/tool fetch url="https://api.telegram.org/bot$BotID/sendMessage?chat_id=$ChatID&text=Download Voucher: $URL$filename" keep-result=no;