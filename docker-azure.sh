#!/bin/sh

echo "Initializing default variables..."
STORAGEACCOUNT="SET"
ACCESSKEY="SET"
SHARENAME="SET"
PROTOCOL_VERSION="3.0"
DIR_PERMISSIONS=0777
FILE_PERMISSIONS=0777
echo;echo;


echo "Populating variables from supplied arguments..."
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
	-h|--help)
    echo "Azure File Storage Mounting"
	echo "---------------------------"
	echo "Syntax docker-azure.sh -u <azure account name> -p <azure storage account key> -s <azure file share name>"
	echo;
	exit 0
    shift # past argument
    shift # past value
    ;;
    -a|--storage_account)
    STORAGEACCOUNT="$2"
    shift # past argument
    shift # past value
    ;;
    -k|--access_key)
    ACCESSKEY="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--share_name)
    SHARENAME="$2"
    shift # past argument
    shift # past value
    ;;
esac
done

echo STORAGEACCOUNT  = "${STORAGEACCOUNT}"
echo ACCESSKEY  = "${ACCESSKEY}"
echo SHARENAME = "${SHARENAME}"
echo;echo;


echo "Bail out if any of the required arguments were skipped..."
if [ "$STORAGEACCOUNT" == "SET" ] || [ "$ACCESSKEY" == "SET" ] || [ "$SHARENAME" == "SET" ] ; then
	echo "One or more parameters were not set properly..."
	echo "Exiting script..."
	exit 1
fi
echo;echo;


echo "Mounting Azure File Storage..."
mount -t cifs \
	//$STORAGEACCOUNT.file.core.windows.net/$SHARENAME \
	/mount \
	-o vers=$PROTOCOL_VERSION,username=$STORAGEACCOUNT,password=$ACCESSKEY,dir_mode=$DIR_PERMISSIONS,file_mode=$FILE_PERMISSIONS,sec=ntlmssp
echo;echo;
