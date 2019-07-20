#!/bin/bash
clear

##
menu1(){
 echo ' *---------------------------------------------------------*'
 echo ' * Deploy the application                                  *'
 echo ' *---------------------------------------------------------*'
 echo ''
 echo " 1 Development environment"
 echo " 2 Staging environment"
 echo " 3 Production environment"
 echo " 4 Production environment maintenance"
 echo -e "\n"
 echo " ---<Choose your environment>------------------------------"
 echo ''
}

selection_dl(){
  echo '·▄▄▄▄  ▄▄▄ . ▌ ▐·▄▄▄ .▄▄▌         ▄▄▄·• ▌ ▄ ·. ▄▄▄ . ▐ ▄ ▄▄▄▄▄'
  echo '██▪ ██ ▀▄.▀·▪█·█▌▀▄.▀·██•  ▪     ▐█ ▄█·██ ▐███▪▀▄.▀·•█▌▐█•██  '
  echo '▐█· ▐█▌▐▀▀▪▄▐█▐█•▐▀▀▪▄██▪   ▄█▀▄  ██▀·▐█ ▌▐▌▐█·▐▀▀▪▄▐█▐▐▌ ▐█.▪'
  echo '██. ██ ▐█▄▄▌ ███ ▐█▄▄▌▐█▌▐▌▐█▌.▐▌▐█▪·•██ ██▌▐█▌▐█▄▄▌██▐█▌ ▐█▌·'
  echo '▀▀▀▀▀•  ▀▀▀ . ▀   ▀▀▀ .▀▀▀  ▀█▄▀▪.▀   ▀▀  █▪▀▀▀ ▀▀▀ ▀▀ █▪ ▀▀▀ '
}

selection_st(){
  echo ' ________  _________  ________  ________  ___  ________   ________ '
  echo '|\   ____\|\___   ___\\   __  \|\   ____\|\  \|\   ___  \|\   ____\'
  echo '\ \  \___|\|___ \  \_\ \  \|\  \ \  \___|\ \  \ \  \\ \  \ \  \___|'
  echo '\ \_____  \   \ \  \ \ \   __  \ \  \  __\ \  \ \  \\ \  \ \  \  ___'
  echo '  \|____|\  \   \ \  \ \ \  \ \  \ \  \|\  \ \  \ \  \\ \  \ \  \|\  \'
  echo '  ____\_\  \   \ \__\ \ \__\ \__\ \_______\ \__\ \__\\ \__\ \_______\'
  echo ' |\_________\   \|__|  \|__|\|__|\|_______|\|__|\|__| \|__|\|_______|'
  echo ' \|_________|'
}

selection_pd(){
  echo '██████╗ ██████╗  ██████╗ ██████╗ ██╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗'
  echo '██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██║   ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║'
  echo '██████╔╝██████╔╝██║   ██║██║  ██║██║   ██║██║        ██║   ██║██║   ██║██╔██╗ ██║'
  echo '██╔═══╝ ██╔══██╗██║   ██║██║  ██║██║   ██║██║        ██║   ██║██║   ██║██║╚██╗██║'
  echo '██║     ██║  ██║╚██████╔╝██████╔╝╚██████╔╝╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║'
  echo '╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝  ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝'
}

ssh_cmd1(){
  eval `ssh-agent`
  ssh-add ＜秘密鍵のパスを指定＞
}

ssh_cmd2(){
  ssh_pid=`ps aux | grep ssh-agent | grep -v grep | awk '{print $2}'`
  for i in $ssh_pid ; do sudo kill $i ; done > /dev/null 2>&1
}

ansible_cmd1(){
  cd /etc/ansible
  ansible-playbook -i hosts -u ＜ユーザ名＞ dl_deploy.yml
}

ansible_cmd2(){
  cd /etc/ansible
  ansible-playbook -i hosts -u ＜ユーザ名＞ st_deploy.yml
}

ansible_cmd3(){
  cd /etc/ansible
  ansible-playbook -i hosts -u ＜ユーザ名＞ pd_deploy.yml
}

ansible_cmd4(){
  cd /etc/ansible
  ansible-playbook -i hosts -u ＜ユーザ名＞ pd_mainte.yml
}

confirmation(){
  read -p "Are you sure you want to proceed?  (y/n) :" YN
  if [ "${YN}" = "y" ]; then
    echo ''
    echo ' *---------------------------------------------------------*'
    echo ' * Deploy start                                            *'
    echo ' *---------------------------------------------------------*'
    echo ''
  else
    echo ''
    echo ' *---------------------------------------------------------*'
    echo ' * Cancel deployment                                       *'
    echo ' *---------------------------------------------------------*'
    echo ''
    exit 0
  fi
}

end_message1(){
  echo ''
  echo ' *---------------------------------------------------------*'
  echo ' * Deploy end succes!!                                     *'
  echo ' *---------------------------------------------------------*'
  echo ''
}

end_message2(){
  echo ''
  echo ' *---------------------------------------------------------*'
  echo ' * Switch to maintenance mode!!                            *'
  echo ' *---------------------------------------------------------*'
  echo ''
}

##
menu1
read inputkey

case ${inputkey} in
 1 ) selection_dl;confirmation;ssh_cmd1;time ansible_cmd1;ssh_cmd2;end_message1;;
 2 ) selection_st;confirmation;ssh_cmd1;time ansible_cmd2;ssh_cmd2;end_message1;;
 3 ) selection_pd;confirmation;ssh_cmd1;time ansible_cmd3;ssh_cmd2;end_message1;;
 4 ) selection_pd;confirmation;ssh_cmd1;time ansible_cmd4;ssh_cmd2;end_message2;;
esac

exit 0
