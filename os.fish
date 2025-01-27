#!/bin/fish
# this script is to use fish to reach the feedback of neofetch
# author : spriple
# time   : 2025-01-19
echo "$(who | cut -d' ' -f1)@$(hostnamectl | grep "Static hostname" | cut -d':' -f2 | xargs)"
echo OS:(hostnamectl | grep "Operating System" | cut -d':' -f2)$(hostnamectl | grep "Architecture" | cut -d':' -f2)
echo Kernel:(hostnamectl | grep "Kernel" | cut -d':' -f2)
echo Uptime:(uptime -p |cut -d' ' -f2,3,4,5)
echo Shell:(echo $SHELL | cut -d'/' -f3)
echo -e "Terminal: \033[1m$(echo $TERM)\033[0m"
echo CPU:(lscpu | grep "Model name" | cut -d':' -f2 | xargs)
echo GPU:(lspci | grep "VGA" | cut -d' ' -f5,7)
echo "Mem: $(free -m | awk '{print $3}' | awk 'NR==2')MiB / $(free -m | awk '{print $2}' | awk 'NR==2')MiB" 
#arch
echo Packages:(count (pacman -Q))
