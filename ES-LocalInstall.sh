 #!/bin/sh
if ([ $# -ne 7 ] )
then 
    if( [ $# -eq 1 ]  && [ $1 = '--help' ] )
    then
        echo ""
        echo "Usage: ES-LocalInstall.sh 'MyPa$sw0rd' 'Collogix' '30g' '30g' '512m'"
        echo "Usage: ES-LocalInstall.sh [user] [IP] [NginxPassword] [SiteName] [HeapSize_A] [HeapSize_B] [HeapSize_M]"
        echo "       NGinx Password: Password for the nginx proxy (ex: 'MyPa$sw0rd')" 
        echo "       SiteName: DataCenter Name (ex: 'Collogix' or 'Querbes')"
        echo "       HeapSize_A: Node A HeapSize memory (ex: '30g')"
        echo "       HeapSize_B: Node B HeapSize memory (ex: '30g')"
        echo "       HeapSize_M: Node M HeapSize memory (ex: '1g')"
        echo ""
    else
        echo ""
        echo "Invalid number of parameters [ --help for details ]"
        echo "Usage: ES-LocalInstall.sh  'MyPa$sw0rd' 'Collogix' '30g' '30g' '512m'"
        echo ""
    fi
else
    echo "###########################"
    echo "# DEBUT DE L'INSTALLATION #"
    echo "###########################"
    echo "# CONFIG DU SERVER LINUX #"
    chmod +x Server-Init.sh
    ./Server-Init.sh

    echo "# CONFIG DE NGINX (PROXY) #"
    chmod +x Nginx-Init.sh
    ./Nginx-Init.sh $1

    echo "# CONFIG DES NOEUDS ELASTICSEARCH #"
    chmod +x ElasticSearch-Init.sh
    # ElasticSearch-Init.sh SiteName HeapSizeNode_A HeapSizeNode_B HeapSizeNode_M #
    ./ElasticSearch-Init.sh $2 $3 $4 $5
    ###############################################################################

    echo "###########################"
    echo "# INSTALLATION TERMINEE ! #"
    echo "###########################"
fi