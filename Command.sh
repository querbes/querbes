#!/bin/sh

if ([ $# -ne 6 ] )
then
    if( [ $# -eq 1 ]  && [ $1 = '--help' ] )
    then
        echo ""
        echo "Usage: script.sh [user] [IP] [SiteName] [HeapSize_A] [HeapSize_B] [HeapSize_M]"
        echo "User: Remote User Login (ex: root)"
        echo "IP: Remote IP Address (ex: 192.168.1.1)"
        echo "SiteName: DataCenter Name (ex: 'Querbes')"
        echo "HeapSize_A: Node A HeapSize memory (ex: '30g')"
        echo "HeapSize_B: Node B HeapSize memory (ex: '30g')"
        echo "HeapSize_M: Node M HeapSize memory (ex: '512m')"
        echo ""
    else
        echo ""
        echo "Invalid number of parameters [ --help for details]"
        echo "Usage: script.sh root 192.168.1.1 'Collogix' '30g' '30g' '512m'"
        echo ""
    fi
else
    ssh -t -o StrictHostKeyChecking=no -l $1 $2 "wget https://github.com/querbes/querbes/raw/master/START-INSTALL.sh;chmod +x START-INSTALL.sh;./START-INSTALL.sh  $3 $4 $5 $6"
fi