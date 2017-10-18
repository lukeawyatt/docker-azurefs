#!/bin/bash

echo "Initializing default variables..."
USERNAME="SET"  # "myaccountname"
PASSWORD="SET"  # "StorageAccountKeyEndingIn=="
SHARENAME="SET" # "mysharename"
PROTOCOL_VERSION="3.0"
DIR_PERMISSIONS=0777
FILE_PERMISSIONS=0777
echo;echo;


echo "Populating variables from supplied arguments..."
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
	-h|--help)
    echo "Azure File Storage Mounting"
	echo "---------------------------"
	echo "Syntax docker-azure.sh -u <azure account name> -p <azure storage account key> -s <azure file share name>"
	echo;
    shift # past argument
    shift # past value
    ;;
    -u|--username)
    USERNAME="$2"
    shift # past argument
    shift # past value
    ;;
    -p|--password)
    PASSWORD="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--sharename)
    SHARENAME="$2"
    shift # past argument
    shift # past value
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

echo USERNAME  = "${USERNAME}"
echo PASSWORD  = "${PASSWORD}"
echo SHARENAME = "${SHARENAME}"
echo;echo;


echo "Bail out if any of the required arguments were skipped..."
if [ "$USERNAME" == "SET" ] || [ "$PASSWORD" == "SET" ] || [ "$SHARENAME" == "SET" ] ; then
	echo "One or more parameters were not set properly..."
	echo "Exiting script..."
	exit 1
fi
echo;echo;


echo "Mounting Azure File Storage..."
sudo mount -t cifs \
	//myaccountname.file.core.windows.net/$SHARENAME \
	/mount \
	-o vers=$PROTOCOL_VERSION,username=$USERNAME,password=$PASSWORD,dir_mode=$DIR_PERMISSIONS,file_mode=$FILE_PERMISSIONS
echo;echo;
