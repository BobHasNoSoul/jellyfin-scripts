#!/bin/bash

# Usernames and passwords (format: username:password)
users=(
  "User1:Password"
  "User2:OhHaiAnotherPasswordHere"
  "user3:oopsididitagainwithapassword"
  "user5:wedontspeakaboutuser4"
)
for user in "${users[@]}"; do
  IFS=':' read -r username password <<< "$user"
# DO NOT FORGET TO CHANGE YOUR API KEY AND IP OF JELLYFIN IN THE NEXT PART OR IT WILL FAIL
  curl -X 'POST' \
    'http://192.168.1.XXX:8096/Users/New' \
    -H 'accept: application/json' \
    -H "X-Emby-Token: YOURAPIKEYHERE" \
    -H 'Content-Type: application/json' \
    -d "{
      \"Name\": \"$username\",
      \"Password\": \"$password\"
    }"
  echo "User $username created."
done
