#!/bin/bash

# args: mount.sh user smb_server server_dir mount_point
ret=0

if [ $# -ne 3 ] && [ $# -ne 4 ]; then
    echo "<E> Invalid args: $@" >&2
    exit 1;
fi

if ! [ $(id -u) -ne 0 ]; then
    echo "Requesting root privilages..."
    sudo -v > /dev/null | exit 1
    echo "Done."
fi

smb_server="${2}"
mount_point="${3}"
creds_file="/etc/.smb_creds"

case $1 in
    "-m")
        server_dir="${4}"

        # Mount
        # Test if server is already mounted
        if [ $(mount | grep -c "^//${smb_server}/${server_dir} on ${mount_point}") -ne 0 ] ; then
            echo "<W> Server is already mounted"
            # Exit with 2 so that we DON'T unmount it later
            exit 2
        else
            nc -z "${smb_server}" 445
            if [ $? -ne 0 ]; then
                echo "<E> Cannot connect to server" >&2
                exit 1
            fi
        fi

        opts="iocharset=utf8,file_mode=0777,dir_mode=0777,credentials=$creds_file"

        echo "Mounting home..."

        if ! [ -d "${mount_point}" ]; then
            echo "<W> ${mount_point} does not exist."
            read -p "Would you like to create the directory? (y/N)" -n 1 -r
            echo

            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo mkdir -p "${mount_point}"
            else
                exit 1
            fi
        fi

        sudo mount -l -t cifs "//${smb_server}/${server_dir}" "${mount_point}" -o $opts
        ret=$?
        echo "Done."
        ;;
    "-u")
        # Unmount
        # Test if the server is mounted
        if ! mount | grep $smb_server &> /dev/null; then
            echo "<W> Server is not mounted"
            exit 0
        fi

        echo "Unmounting home..."
        if [ ! -d "$mount_point" ]; then
            echo "<E> Mount point ${mount_point} is not a directory"
            ret=1
        else
            sudo umount "$mount_point"
            ret=$?
        fi
        echo "Done."
        ;;
    *)
        echo "<E> Invalid Option: $1" >&2
        ret=1
    ;;
esac

exit $ret
