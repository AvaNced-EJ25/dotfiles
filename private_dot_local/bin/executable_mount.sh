#!/bin/bash

# args: mount.sh user smb_server server_dir mount_point
ret=0

if [ $# -lt 4 ]; then
    echo "Invalid args: $@"
    exit 1;
fi

if [ ! $(id -u) -ne 0 ]; then
    echo "Requesting root privilages..."
    sudo -v > /dev/null | exit 1
    echo "Done."
fi

smb_username="${1}"
smb_server="//${2}"
server_dir="${3}"
mount_point="${4}"
creds_file="/tmp/creds"

if mount | grep $smb_server &> /dev/null; then
    # Unmount
    echo "Unmounting home..."
    sudo umount "$mount_point"
    ret=$?
    echo "Done."
else
    smb_password=""
    while [ -z "$smb_password" ]; do
        read -p "Enter Password for ${smb_server}: " -s smb_password
        echo ""
    done

    echo "username=$smb_username" > $creds_file
    echo "password=$smb_password" >> $creds_file
    unset smb_password

    opts="iocharset=utf8,file_mode=0777,dir_mode=0777,credentials=$creds_file"

    echo "Mounting home..."
    sudo mount -l -t cifs "${smb_server}/${server_dir}" "${mount_point}" -o $opts
    ret=$?
    echo "Done."

    rm -f $creds_file
fi

exit $ret
