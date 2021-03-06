 #!/bin/sh

if ([ $# -ne 7 ] )
then 
    if( [ $# -eq 1 ]  && [ $1 = '--help' ] )
    then
        echo ""
        echo "Usage: ES-RemoteDeploy.sh root 192.168.1.1 'MyPa$sw0rd' 'Collogix' '30g' '30g' '512m'"
        echo "Usage: ES-RemoteDeploy.sh [user] [IP] [NginxPassword] [SiteName] [HeapSize_A] [HeapSize_B] [HeapSize_M]"
        echo "       User: Remote User Login (ex: root)"
        echo "       IP: Remote IP Address (ex: 192.168.1.1)"
        echo "       NGinx Password: Password for the nginx proxy (ex: 'MyPa$sw0rd')" 
        echo "       SiteName: DataCenter Name (ex: 'Collogix' or 'Querbes')"
        echo "       HeapSize_A: Node A HeapSize memory (ex: '30g')"
        echo "       HeapSize_B: Node B HeapSize memory (ex: '30g')"
        echo "       HeapSize_M: Node M HeapSize memory (ex: '1g')"
        echo ""
    else
        echo ""
        echo "Invalid number of parameters [ --help for details ]"
        echo "Usage: ES-RemoteDeploy.sh root 192.168.1.1  'MyPa$sw0rd' 'Collogix' '30g' '30g' '1g'"
        echo ""
    fi
else
    ssh -t -o StrictHostKeyChecking=no -l $1 $2 "wget https://github.com/querbes/querbes/raw/master/ES-LocalDeploy.sh --no-check-certificate;chmod +x ES-LocalDeploy.sh;./ES-LocalDeploy.sh $3 $4 $5 $6 $7"
fi

