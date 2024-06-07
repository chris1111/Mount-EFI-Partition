#!/bin/bash
# Mount-EFI-Partition: by chris1111
# Copyright © 2024 chris1111 All Right Reserved.
apptitle="Mount-EFI-Partition"
version="1.0"
# Set Icon directory and file 
iconfile="/System/Library/CoreServices/Finder.app/Contents/Resources/Finder.icns"
printf '\e[8;47;83t'
echo " "
response=$(osascript -e 'tell app "System Events" to display dialog "Mount EFI Partition\n\nCancel for Quit" buttons {"Cancel","Mount EFI"} default button 2 with title "'"$apptitle"' '"$version"'" with icon POSIX file "'"$iconfile"'"  ')

        action=$(echo $response | cut -d ':' -f2)

        # Exit if Canceled
        if [ ! "$action" ] ; then
          osascript -e 'display notification "Program closing" with title "'"$apptitle"'" subtitle "User cancelled"'
          echo "User cancelled Program MountESP closing in 2 sec"
          Sleep 2
          exit 1
        fi

        if [ "$action" == "Mount EFI" ] ; then
        Sleep 1
        diskutil list
        #get EFI Device
        if [ "$2" == "" ]; then
        echo " "
        echo "SIP must be Disable!"
        echo "Enter disk number to Mount EFI Partition:"

        while [ -z "$EFI" ]; do
        read EFI
        done

        else
        EFI="$2"
        fi
        mkdir -p /Private/tmp/EFI
        echo "Type your password to continue!"
        sudo umount -f /dev/disk"$EFI"s1
        sudo mount -t msdos /dev/disk"$EFI"s1 /Private/tmp/EFI
        echo "Mount EFI Partition -> /Volumes/EFI"
        fi
