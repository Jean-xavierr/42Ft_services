#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    dependencies.sh                                    :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Jeanxavier <Jeanxavier@student.42.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/04 15:43:50 by Jeanxavier        #+#    #+#              #
#    Updated: 2020/09/04 15:43:50 by Jeanxavier       ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Color Text
################################################################################

# Red="\e[31m"			#--------- Red color
Light_red="\e[91m"		#--------- Light red color
Green="\e[32m"			#--------- Green color
Yellow="\e[33m"			#--------- Yellow color
Blue="\e[34m"			#--------- Blue color
Default_color="\e[39m"	#--------- Default color

################################################################################


# check_error()
# {

# }

load_animation()
{
	sleep 3
	spin='-\|/'
	# i=0
	while kill -0 $1 2>/dev/null
	do
		# i=$(( (i+1) %4 ))
		# printf "\r${spin:$i:1}"
		printf "\r🤖 : Install in progress "
	  	printf "${spin:i++%${#spin}:1}"
	  	sleep .1
	done
}

install_virtualbox()
{
	if [ "$(VboxManage > /dev/null && echo $?)" == "0" ]; then
			printf "✅ : VirtualBox installed\n"
	else
		printf "❗ : Please install ${Light_red}VirtualBox"
		printf "for Mac from the MSC (Managed Software Center)${Default_color}\n"
		open -a "Managed Software Center"
		# read -p ❗\ :\ Press\ $'\033[0;34m'RETURN$'\033[0m'\ when\ you\ have\ successfully\ installed\ VirtualBox\ for\ Mac\ ...
		# printf "\n"
		exit
	fi
}

move_docker_goinfre()
{
	rm -rf ~/Library/Containers/com.docker.docker ~/.docker
    mkdir -p /Volumes/Storage/goinfre/$USER/docker/{com.docker.docker,.docker}
    ln -sf /Volumes/Storage/goinfre/$USER/docker/com.docker.docker ~/Library/Containers/com.docker.docker
    ln -sf /Volumes/Storage/goinfre/$USER/docker/.docker ~/.docker
}

install_docker()
{
	if [ -d "/Applications/Docker.app" ]; then
		if [ "$(ls -la ~ | grep .docker | cut -d " " -f 18-99)" != ".docker -> /Volumes/Storage/goinfre/$USER/docker/.docker" ] || [ ! -d "/Volumes/Storage/goinfre/$USER/.docker" ]; then
			move_docker_goinfre
		else
			open -a Docker && sleep 5
		fi
	else
		printf "❗ : Please install ${Light_red}Docker"
		printf "for Mac from the MSC (Managed Software Center)${Default_color}\n"
		open -a "Managed Software Center"
		# read -p ❗\ :\ Press\ $'\033[0;34m'RETURN$'\033[0m'\ when\ you\ have\ successfully\ installed\ Docker\ for\ Mac\ ...
		# move_docker_goinfre
		exit
	fi
	printf "🐳 : Docker installed\n"
}

install_brew()
{
	if [ "$(brew list > /dev/null 2>&1 && echo $?)" != "0" ]; then
		rm -rf $HOME/.brew &
		git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew &
		echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc &
		source $HOME/.zshrc &
		brew update
	fi
	printf "🤖 : Brew installed\n"
}

move_minikube_goinfre()
{
	mv ~/.minikube /Volumes/Storage/goinfre/$USER/ &> /dev/null
	ln -sf /Volumes/Storage/goinfre/$USER/.minikube /Users/$USER/.minikube
	mkdir /Volumes/Storage/goinfre/$USER/.minikube &> /dev/null
}

install_minikube()
{
	if [ "$(brew list | grep minikube)" != "minikube" ]; then
		printf "🤖 : Install Minikube\n"
		brew install minikube &> /dev/null & 
		load_animation $!
		printf "\b \n"
		move_minikube_goinfre
	elif [ "$(ls -la ~ | grep .minikube | cut -d " " -f 18-99)" != ".minikube -> /Volumes/Storage/goinfre/$USER/.minikube" ] || [ ! -d "/Volumes/Storage/goinfre/$USER/.minikube" ]; then
		move_minikube_goinfre
	fi
	printf "🐳 : Minikube installed\n"
}

install_dependencies_42mac()
{
	install_virtualbox
	install_docker
	install_brew
	install_minikube
}

main()
{
	if [ $1 == "42Mac" ]; then
		install_dependencies_42mac
	fi
}

main "$1"