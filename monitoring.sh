#!/bin/bash
wall $'#Architecture: ' `hostnamectl | grep "Operating System" | cut -d ' ' -f5- ` `awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//'` `arch` \
$'\n#Processeurs physiques: '`cat /proc/cpuinfo | grep processor | wc -l` \
$'\n#Processeurs virtuels:  '`cat /proc/cpuinfo | grep processor | wc -l` \
$'\n'`free -m | awk 'NR==2{printf "#Utilisation memoire vive: %s/%sMB (%.2f%%)", $3,$2,$3*100/$2 }'` \
$'\n'`df -h | awk '$NF=="/"{printf "#Utilisation memoire: %d/%dGB (%s)", $3,$2,$5}'` \
$'\n'`top -bn1 | grep load | awk '{printf "#utilisation des processeurs: %.2f\n", $(NF-2)}'` \
$'\n#dernier redemarage: ' `who -b | awk '{print $3" "$4" "$5}'` \
$'\n#LVM: ' `lsblk |grep lvm | awk '{if ($1) {print "yes";exit;} else {print "no"} }'` \
$'\n#Connections:' `netstat -an | grep ESTABLISHED |  wc -l` \
$'\n#Nombre d\'utilisateurs: ' `who | cut -d " " -f 1 | sort -u | wc -l` \
$'\IPv4: IP ' `hostname -I`"("`ip a | grep link/ether | awk '{print $2}'`")" \
$'\n#Nombre de commandes Sudo:  ' `grep 'sudo ' /var/log/auth.log | wc -l`
