# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jereligi <jereligi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/18 16:24:05 by jereligi          #+#    #+#              #
#    Updated: 2020/08/18 17:24:22 by jereligi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

printf "\nScript to setup Kubernetes and Docker "

# Visuel download
for i in `seq 0 2`
do
	printf "." && sleep 0.5
done
printf " 🚀\n\n"

# Function for 42Mac
function_42Mac()
{
	printf "Function $1 🍎\n"
	# # Install virtualbox
	# echo "Install Virtualbox ..."

	# # Install Kubernetes
	# echo "Install Kubernetes ... 🐳"
	# brew install kubectl
	# brew install minikube

	# # Install Docker
	# echo "Install Docker ..."
}

# Function for 42Ubuntu
function_42Ubuntu()
{
	printf "Function $1 🐧\n"
}

if [ $1 == "42Mac" ]; then
	function_42Mac $1
elif [ $1 == "42Ubuntu" ]; then
	function_42Ubuntu $1
fi
