# jellyfin-scripts
a random place for scripts to automate random things jellyfin related.. there is no support given more of a stop sending me messages about the same thing type deal
simply edit the scripts in this repo to have your api key and url so it can send the desired api calls to quickly populate a new install with dirs you have predefined over a lot of drives in linux (sorry windows i really dont know if it works on windows.. i mean it should but again no support to be given on these)

Scripts in this repo:
add users script - This script will litterally batch add a lot of users to jellyfin using the api key requirements.. a working install and a api key from your admin page.. simply edit the api and url and add your own users in the list and run the script.

add libraries script - this will make libraries with all the folders across all of your hdds or where-ever (mine are over 28 hdds so the use case is quite rare but go figure no one else made a script for it and i recently had a new hdd installed to boot from so yay me i guess rebuilding on a new system with the same media mount points) so simply edit the paths and names of the libraries (YOU MUST MAKE THE LIBRARY WITH THE CORRECT NAMES FIRST JUST ADD AN EMPTY DIR IN THE WEB UI) then run the script once it will add all of the dirs to the corresponding libraries (yes i could have made dupe detection and creation but tbh its a quick and dirty way of doing it) 

thats it for now.. more to come maybe in the future when i get more time 
