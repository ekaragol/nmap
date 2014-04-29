#!/bin/bash
if [[ $1 == "--help" || $1 == "-help" || ! $# -eq 3 ]]; then
        echo "Kullanım şu şekildedir:" echo " ./filtre.sh nmap_sonuc_dosyasi port_numarasi protokol"
else
        bool="0"
        cat $1 | while read -r line
        do
                ip=`echo "$line" | grep "Nmap scan report for"`
                if [ $? -eq 0 ]; then
                        rip=`echo $ip | cut -d " " -f5`
                        bool="0"
                else
                        status=`echo "$line" | grep "^$2/$3" | grep "open "`
                        if [ $? -eq 0 ]; then
                                if [ $bool -eq "0" ]; then
                                        echo $rip
                                        bool="1"
                                fi
                        fi
                fi
        done
fi
