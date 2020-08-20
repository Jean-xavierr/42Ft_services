#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jereligi <jereligi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/18 16:24:05 by jereligi          #+#    #+#              #
#    Updated: 2020/08/20 13:44:08 by jereligi         ###   ########.fr        #
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

# Function Script
################################################################################

function_install_virtualbox()
{
	# cat test > /dev/null 2>&1
	if [ "$(VboxManage > /dev/null && echo $?)" == "0" ]; then
			printf "VirtualBox installed\n"
	else
		if [ $1 == "42Mac" ]; then
			printf "${Yellow}Warning :${Default_color} Please install ${Light_red}VirtualBox"
			printf "for Mac from the MSC (Managed Software Center)${Default_color} ❗\n"
			open -a "Managed Software Center"
			printf "\t  "
			read -p Press\ $'\033[0;34m'RETURN$'\033[0m'\ when\ you\ have\ successfully\ installed\ VirtualBox\ for\ Mac\ ...
			printf "\n"
		fi
	fi
}

function_move_docker_goinfre()
{
	rm -rf ~/Library/Containers/com.docker.docker ~/.docker
    mkdir -p /Volumes/Storage/goinfre/$USER/docker/{com.docker.docker,.docker}
    ln -sf /Volumes/Storage/goinfre/$USER/docker/com.docker.docker ~/Library/Containers/com.docker.docker
    ln -sf /Volumes/Storage/goinfre/$USER/docker/.docker ~/.docker
}

function_install_docker()
{
	if [ $1 == "42Mac" ]; then
		if [ -d "/Applications/Docker.app" ]; then
			printf "Docker installed 🐳\n"
			if [ "$(ls -la ~ | grep .docker | cut -d " " -f 18-99)" != ".docker -> /Volumes/Storage/goinfre/$USER/docker/.docker" ] || [ ! -d "/Volumes/Storage/goinfre/$USER/.docker" ]; then
				function_move_docker_goinfre
			else
				open -a Docker && sleep 5
			fi
		else
			printf "Please install ${Light_red}Docker"
			printf "for Mac from the MSC (Managed Software Center)${Default_color} ❗\n"
			open -a "Managed Software Center"
			read -p Press\ $'\033[0;34m'RETURN$'\033[0m'\ when\ you\ have\ successfully\ installed\ Docker\ for\ Mac\ ...
			function_move_docker_goinfre 
		fi
	else
		printf "Install Docker on 42VM"
	fi
}

function_install_brew()
{
	if [ "$1" == "42Mac" ]; then
		if [ "$(brew list > /dev/null 2>&1 && echo $?)" != "0" ]; then
			rm -rf $HOME/.brew &
			git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew &
			echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc &
			source $HOME/.zshrc &
			brew update
		fi
	fi
}

function_install_kubernetes()
{
	if [ "$(brew list | grep kubernetes-cli)" != "kubernetes-cli" ]; then
		brew install kubernetes-cli
	fi
	printf "Kubernetes installed 🐳\n"
}

function_move_minikube_goinfre()
{
	mv ~/.minikube /Volumes/Storage/goinfre/$USER/
	ln -sf /Volumes/Storage/goinfre/$USER/.minikube /Users/$USER/.minikube
	mkdir /Volumes/Storage/goinfre/$USER/.minikube
}

function_install_minikube()
{
	if [ "$1" == "42Mac" ]; then
		if [ "$(brew list | grep minikube)" != "minikube" ]; then
			brew install minikube
			function_move_minikube_goinfre
		elif [ "$(ls -la ~ | grep .minikube | cut -d " " -f 18-99)" != ".minikube -> /Volumes/Storage/goinfre/$USER/.minikube" ] || [ ! -d "/Volumes/Storage/goinfre/$USER/.minikube" ]; then
			function_move_minikube_goinfre
		fi
	fi
	printf "Minikube installed 🐳\n"
}

function_management_install()
{
	function_install_virtualbox "$1"
	function_install_docker "$1"
	function_install_brew "$1"
	function_install_kubernetes
	function_install_minikube $1
}

function_print_usage()
{
	printf "${Blue}Usage :${Default_color} ./setup.sh [${Green}42Mac${Default_color}|${Green}42Linux${Default_color}]\n"
	printf "\t Use ${Green}42Mac${Default_color} if you are on a 42Mac\n"
	printf "\t Use ${Green}42Linux${Default_color} if you are on a 42VM\n"
	printf "\n${Blue}Exemple :${Default_color} ./setup.sh 42Mac\n"
}

function_main()
{
	# Visuel print
	printf "\nScript to setup Kubernetes and Docker "
	for _ in $(seq 0 2)
	do
		printf "." && sleep 0.5
	done
	printf " 🚀\n\n"

	# check if they are an argument
	if [ "$1" == "" ]; then
		printf "${Light_red}Error :${Default_color} the program needs an argument\n"
		function_print_usage
	elif [ "$1" != "42Mac" ] && [ "$1" != "42Linux" ]; then
		printf "${Light_red}Error :${Default_color} argument no correct\n"
		function_print_usage
	else
		if [ "$1" == "42Mac" ]; then
			printf "Function %s 🍎\n\n" "$1"
			function_management_install "$1"
		elif [ "$1" == "42Linux" ]; then
			printf "Function %s 🐧\n\n" "$1"
			function_management_install "$1"
		fi
	fi
}

################################################################################

function_main "$1"

################################################################################
