#!/bin/bash
ret=0

echo "Requesting root privilages..."
sudo -v > /dev/null | exit 1
echo "Done."

# TODO: Some of these should be environment variables instead
mount_point="/mnt"
creds_file="/tmp/creds"
smb_server="//steve.koman"
smb_username="andrew"
smb_password=""

if mount | grep $smb_server; then
    # Unmount
    echo "Unmounting home..."
    sudo umount "$mount_point/home"
    ret=$?
    echo "Done."
else
    while [ -z "$smb_password" ]; do
        read -p "Enter Password for steve.koman: " -s smb_password
        echo ""
    done

    echo "username=$smb_username" > $creds_file
    echo "password=$smb_password" >> $creds_file

    opts="iocharset=utf8,file_mode=0777,dir_mode=0777,credentials=$creds_file"

    echo "Mounting home..."
    sudo mount -l -t cifs "$smb_server/home" "$mount_point/home" -o $opts
    ret=$?
    echo "Done."

    rm -f $creds_file
fi

exit $ret
