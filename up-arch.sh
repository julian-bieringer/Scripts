#!/bin/zsh
echo -e "\033[32m**************************************************\033[0m"
echo -e "\033[32m*                  pacman -Syyu                  *\033[0m"
echo -e "\033[32m**************************************************\033[0m"
sudo pacman -Syyu
echo ""
echo -e "\033[32m**************************************************\033[0m"
echo -e "\033[32m*         pamac checkupdates -a --devel          *\033[0m"
echo -e "\033[32m**************************************************\033[0m"
upgradeable=$(pamac checkupdates -a --devel | tail -n +2 | awk '{ print $1 }')
echo $upgradeable
echo ""
while read line; do
	if [ "$line"  = '' ]; then
                continue;
        fi
	if [ "$line"  = 'Out' ]; then
		break;
	fi
	echo "";
	echo -e "\033[32m*pamac build $line*\033[0m";
	pamac build --no-confirm $line;
	echo "";
done <<< "$upgradeable"
