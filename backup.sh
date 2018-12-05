cd ~/
echo "searching for ~/backup"
mkdir -p backup
printf "\ncompressing ~/Documents\n"
lrztar -o backup/Documents.tar.lrz -z Documents
echo "done compressing"
