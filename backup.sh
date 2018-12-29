cd ~/
echo "searching for ~/backup"
mkdir -p backup
today=$(date --iso-8601)
echo "creating directory for $today"
mkdir -p backup/$today
printf "\ncompressing hidden directories\n"
for f in .[^.]*; do
	if [ $f == ".config" ] || [ $f == ".cache" ] || [ $f == ".local" ]; then
		printf "\nomitting $f directory\n";
		continue;
	fi
	printf "\ncompressing $f\n";
	lrztar -o backup/$today/$f.tar.lrz -z $f;
done
echo "done compressing"
printf "\ncompressing ~/Documents\n"
lrztar -o backup/$today/Documents.tar.lrz -z Documents
echo "done compressing"
printf "\ncompressing ~/Pictures\n"
lrztar -o backup/$today/Pictures.tar.lrz -z Pictures
echo "done compressing"
printf "\ncompressing ~/Music\n"
lrztar -o backup/$today/Music.tar.lrz -z Music
echo "done compressing"
