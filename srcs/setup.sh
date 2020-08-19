# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jereligi <jereligi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/18 16:24:05 by jereligi          #+#    #+#              #
#    Updated: 2020/08/19 17:34:43 by jereligi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# Color Text
################################################################################

Red="\e[31m"			#--------- Red color
Light_red="\e[91m"		#--------- Light red color
Green="\e[32m"			#--------- Green color
Yellow="\e[33m"			#--------- Yellow color
Blue="\e[34m"			#--------- Blue color
Default_color="\e[39m"	#--------- Default color

################################################################################

# Function Script
################################################################################
function_42Mac()
{
	printf "Function $1 🍎\n\n"
	# Install VirtualBox
	VboxManage > /dev/null
	cat titi > /dev/null 2>&1
	if [ $? == "0" ]; then
		printf "VirtualBox installed"
	elif [ $? != "0" ]; then
		printf "Install VirtualBox ...\n"
		printf "Please install ${Light_red}VirtualBox "
		printf "for Mac from the MSC (Managed Software Center)${Default_color} ❗\n"
		# open -a "Managed Software Center"
		read -p Press\ $'\033[0;34m'RETURN$'\033[0m'\ when\ you\ have\ successfully\ installed\ VirtualBox\ for\ Mac\ ...
	fi

	# # Install Kubernetes
	echo "Install Kubernetes ... 🐳"
	# brew install kubectl
	# brew install minikube

	# # Install Docker
	# echo "Install Docker ..."
}

function_42Ubuntu()
{
	printf "Function $1 🐧\n"
}
################################################################################


# Start Script
################################################################################
printf "\nScript to setup Kubernetes and Docker "
# Visuel download
for i in `seq 0 2`
do
	printf "." && sleep 0.5
done
printf " 🚀\n\n"

if [ $1 == "42Mac" ]; then
	function_42Mac $1
elif [ $1 == "42Ubuntu" ]; then
	function_42Ubuntu $1
fi
################################################################################
