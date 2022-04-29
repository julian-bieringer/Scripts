#!/bin/bash
echo -e "\033[32m**************************************************\033[0m"
echo -e "\033[32m*                  pacman -Syyu                  *\033[0m"
echo -e "\033[32m**************************************************\033[0m"
sudo pacman -Syyu
echo ""
echo -e "\033[32m**************************************************\033[0m"
echo -e "\033[32m*              pamac checkupdates -a             *\033[0m"
echo -e "\033[32m**************************************************\033[0m"
pamac checkupdates -a
echo ""
echo -e "\033[32m**************************************************\033[0m"
echo -e "\033[32m*                pamac upgrade -a                *\033[0m"
echo -e "\033[32m**************************************************\033[0m"
pamac upgrade -a