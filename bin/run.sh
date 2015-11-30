#!/bin/bash

set -e
[ "$DEBUG" == "1" ] && set -x && set +e


if [ "${NFS_SERVER}" == "*" -o -z "${NFS_SERVER}" ]; then
   NFS_SERVER=${NFS_SERVER}
fi


if [ "${NFS_REMOTE}" == "*" -o -z "${NFS_REMOTE}" ]; then
   NFS_REMOTE=${NFS_REMOTE}
fi


### MOUNT NFS

mkdir -p /nfs
mount -t nfs ${NFS_SERVER}:${NFS_REMOTE} /nfs


### FTP
if [ "${FTP}" == "**NO**" -o -z "${FTP}" ]; then
   FTP=${FTP}
fi


if [ "${FTP}" == "YES" ]; then

if [ "${FTP_LOGIN}" == "flotix" -o -z "${FTP_LOGIN}" ]; then
   FTP_LOGIN=${FTP_LOGIN}
fi

if [ "${FTP_PASSWD}" == "**ChangeMe**" -o -z "${FTP_PASSWD}" ]; then
   FTP_PASSWD=${FTP_PASSWD}
fi


# User
adduser --quiet --disabled-password -shell /bin/false --home /nfs --gecos "FTP" ${FTP_LOGIN}
echo "${FTP_LOGIN}:${FTP_PASSWD}" | chpasswd




fi

/usr/bin/supervisord
