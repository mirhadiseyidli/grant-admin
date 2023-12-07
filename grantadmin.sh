#!/bin/bash

# Get currently logged in user
loggedInUser=$(stat -f "%Su" /dev/console)

# Make logged in user admin
      if [ "$loggedInUser" != "getcruise" ]; then
        IsUserAdmin=$(id -G "$loggedInUser"| grep 80)
            if [ -n "$IsUserAdmin" ]; then
                echo "$loggedInUser is already an admin"
                exit 0
            else
                echo "promoting $loggedInUser to admin"
                /usr/bin/dscl . -append /groups/admin GroupMembership "$loggedInUser"
                # logging out to enforce the change.
                pkill loginwindow
                exit 0
            fi
      fi 
