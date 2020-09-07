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

# Color Text and display variable 
################################################################################

# Red="\e[31m"			#--------- Red color
Light_red="\e[91m"		#--------- Light red color
Green="\e[32m"			#--------- Green color
Yellow="\e[33m"			#--------- Yellow color
Blue="\e[34m"			#--------- Blue color
Default_color="\e[39m"	#--------- Default color

ft_services= 
printf "\n\n
███████╗████████╗     ███████╗███████╗██████╗ ██╗   ██╗██╗ ██████╗███████╗███████╗
██╔════╝╚══██╔══╝     ██╔════╝██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝██╔════╝
█████╗     ██║        ███████╗█████╗  ██████╔╝██║   ██║██║██║     █████╗  ███████╗
██╔══╝     ██║        ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║     ██╔══╝  ╚════██║
██║        ██║███████╗███████║███████╗██║  ██║ ╚████╔╝ ██║╚██████╗███████╗███████║
╚═╝        ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝╚══════╝╚══════╝
\n\n"

################################################################################

print_usage()
{
	printf "${Blue}Usage :${Default_color} ./setup.sh [${Green}42Mac"
	printf "${Default_color}|${Green}42Linux${Default_color}]\n"
	printf "\t Use ${Green}42Mac${Default_color} if you are on a 42Mac\n"
	printf "\t Use ${Green}42Linux${Default_color} if you are on a 42VM\n"
	printf "\n${Blue}Exemple :${Default_color} ./setup.sh 42Mac\n\n"
}

parsing_argument()
{
	$ft_services
	if [ "$1" == "" ]; then
		printf "${Light_red}Error :${Default_color} the program needs an argument\n"
		print_usage
	elif [ "$1" != "42Mac" ] && [ "$1" != "42Linux" ]; then
		printf "${Light_red}Error :${Default_color} argument no correct\n"
		print_usage
	else
		if [ "$1" == "42Mac" ]; then
			printf "🍎 : Function %s\n\n" "$1"
			bash setup_srcs/dependencies.sh "$1"
			bash setup_srcs/build_kubernetes.sh "$1"
		elif [ "$1" == "42Linux" ]; then
			printf "🐧 : Function %s\n\n" "$1"
			sudo usermod -aG docker $(whoami);
			sudo apt install fonts-noto-color-emoji > /dev/null
			bash setup_srcs/build_kubernetes.sh  "$1"
		fi
	fi
}

main()
{
	parsing_argument "$1"
}

main "$1"
