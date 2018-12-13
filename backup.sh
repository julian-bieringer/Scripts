cd ~/
echo "searching for ~/backup"
mkdir -p backup
today=$(date --iso-8601)
echo "creating directory for $today"
mkdir -p backup/$today
printf "\ncompressing bash_history\n"
lrztar -z backup/$today/bash_history.tar.lrz -z .bash_history
echo "done compressing"
printf "\ncompressing ~/Documents\n"
lrztar -z backup/$today/Documents.tar.lrz -z Documents
echo "done compressing"
printf "\ncompressing ~/Pictures\n"
lrztar -z backup/$today/Pictures.tar.lrz -z Pictures
echo "done compressing"
printf "\ncompressing ~/Music\n"
lrztar -z backup/$today/Music.tar.lrz -z Music
echo "done compressing"
