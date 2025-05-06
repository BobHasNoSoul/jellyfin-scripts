#!/bin/bash
echo "THIS SCRIPT WILL LITTERALLY JUST ADD FOLDERS TO PRE EXISTING LIBRARIES SO CREATE SOME FAKE ONES WITH THE CORRECT NAMES, Movies, Shows, Adult, Courses, Music, Fitness then proceed THIS HAS NO DUPE PROTECTION"
echo ""
echo "if you are unsure what to do you will need to press ctrl+x in the next 10 seconds or it will proceed"
echo "if you need to do some but not all comment out the lower lines in this script"
sleep 10
# Configuration
JELLYFIN_URL="http://192.168.1.XXX:8096"  # Change to your Jellyfin server URL
API_KEY="YOURAPIKEYHERE"  # Replace with your API key
HEADERS=(
    -H "accept: application/json"
    -H "X-Emby-Token: $API_KEY"
    -H "Content-Type: application/json"
)
TIMEOUT=30  
add_media_paths() {
    local LIBRARY_NAME="$1"
    shift
    local PATHS=("$@")
    local REFRESH_LIBRARY=true

    echo "Adding ${#PATHS[@]} paths to Jellyfin library '$LIBRARY_NAME'..."

    for path in "${PATHS[@]}"; do
        echo "Adding path: $path"
        REQUEST_BODY=$(jq -n \
            --arg name "$LIBRARY_NAME" \
            --arg path "$path" \
            '{
                "Name": $name,
                "Path": $path
            }')
        RESPONSE=$(curl -s --max-time $TIMEOUT -X POST "$JELLYFIN_URL/Library/VirtualFolders/Paths?refreshLibrary=$REFRESH_LIBRARY" \
            "${HEADERS[@]}" \
            -d "$REQUEST_BODY")
        CURL_EXIT_CODE=$?
        if [ $CURL_EXIT_CODE -eq 28 ]; then
            echo "ERROR: Request timed out after $TIMEOUT seconds"
            return 1
        elif [ $CURL_EXIT_CODE -ne 0 ]; then
            echo "ERROR: curl failed with exit code $CURL_EXIT_CODE"
            return 1
        fi
        if [[ -z "$RESPONSE" ]]; then
            echo "Successfully added path '$path' to library '$LIBRARY_NAME'"
        else
            echo "Error: Failed to add path '$path' to library '$LIBRARY_NAME'"
            echo "Response: $RESPONSE"
            return 1
        fi
    done
}

#start the list of paths for whatever library you are listing
MOVIE_PATHS=(
    "/mnt/10TB2/Movies"
    "/mnt/10TB3/Movies"
    "/mnt/10TB4/Movies"
    "/mnt/10TB/Movies"
    "/mnt/1TB2/Movies"
    "/mnt/1TB3/Movies"
    "/mnt/232GB/Movies"
    "/mnt/465GB2/Movies"
    "/mnt/4TB2/Movies"
    "/mnt/4TB4/Movies"
    "/mnt/4TB5/Movies"
    "/mnt/4TB6/Movies"
    "/mnt/4TB7/Movies"
    "/mnt/4TB8/Movies"
    "/mnt/4TB/Movies"
    "/mnt/500GB/Movies"
    "/mnt/8TB2/Movies"
    "/mnt/8TB3/Movies"
    "/mnt/8TB/Movies"
    "/mnt/HP2/Movies"
    "/mnt/HUBUSB/Movies"
)
 
TV_PATHS=(
    "/mnt/10TB2/TV"
    "/mnt/10TB3/TV"
    "/mnt/10TB4/TV"
    "/mnt/10TB/TV"
    "/mnt/12TB/TV"
    "/mnt/149GB/TV"
    "/mnt/1TB2/TV"
    "/mnt/1TB3/TV"
    "/mnt/232GB/TV"
    "/mnt/465GB2/TV"
    "/mnt/4TB2/TV"
    "/mnt/4TB4/TV"
    "/mnt/4TB5/TV"
    "/mnt/4TB6/TV"
    "/mnt/4TB7/TV"
    "/mnt/4TB8/TV"
    "/mnt/4TB/TV"
    "/mnt/500GB/TV"
    "/mnt/8TB2/TV"
    "/mnt/8TB3/TV"
    "/mnt/8TB/TV"
    "/mnt/HP2/TV"
    "/mnt/HUBUSB/TV"
)
ADULT_PATHS=(
    "/mnt/10TB2/Adult"
    "/mnt/10TB/Adult"
    "/mnt/8TB2/Adult"
    "/mnt/8TB/Adult"
)
MUSIC_PATHS=(
    "/mnt/10TB2/Music"
    "/mnt/10TB3/Music"
    "/mnt/10TB4/Music"
    "/mnt/10TB/Music"
    "/mnt/1TB2/Music"
    "/mnt/1TB3/Music"
    "/mnt/232GB/Music"
    "/mnt/465GB2/Music"
    "/mnt/4TB2/Music"
    "/mnt/4TB4/Music"
    "/mnt/4TB5/Music"
    "/mnt/4TB6/Music"
    "/mnt/4TB7/Music"
    "/mnt/4TB8/Music"
    "/mnt/4TB/Music"
    "/mnt/500GB/Music"
    "/mnt/8TB2/Music"
    "/mnt/8TB3/Music"
    "/mnt/8TB/Music"
    "/mnt/HP2/Music"
    "/mnt/HUBUSB/Music"
)
COURSES_PATHS=(
    "/mnt/10TB4/webdav/data/Courses"
)
FITNESS_PATHS=(
    "/mnt/10TB2/Fitness"
    "/mnt/4TB2/Fitness"
    "/mnt/4TB5/Fitness"
    "/mnt/8TB/Fitness"
)
# UNCOMMENT THE BELLOW FOR WHATEVER CORRESPONDS TO YOUR PATHS AND NAMES ABOVE to add or change the name of the library just change the part in quotes that says Adult or Courses the part later is to match the mist to it so make sure that var points to your list or whatever
add_media_paths "Movies" "${MOVIE_PATHS[@]}"
echo
#add_media_paths "Shows" "${TV_PATHS[@]}"
#echo
#add_media_paths "Adult" "${ADULT_PATHS[@]}"
#echo
#add_media_paths "Music" "${MUSIC_PATHS[@]}"
#echo
#add_media_paths "Courses" "${COURSES_PATHS[@]}"
#echo
#add_media_paths "Fitness" "${FITNESS_PATHS[@]}"
#echo
#add_media_paths "Home Videos" "${HOMEVIDEO_PATHS[@]}"

echo
exit 0
