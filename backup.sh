cd /tmp
echo "creating backup"
dtoday=$(date --iso-8601)
tar --exclude ~/NO_BACKUP -cvzpf /tmp/$dtoday.tar.gz ~/
echo "moving to home directory"
mv $dtoday.tar.gz ~/
echo "done compressing"
