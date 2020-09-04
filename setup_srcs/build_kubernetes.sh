#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup_kubernetes.sh                                :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Jeanxavier <Jeanxavier@student.42.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/04 15:44:08 by Jeanxavier        #+#    #+#              #
#    Updated: 2020/09/04 15:44:08 by Jeanxavier       ###   ########.fr        #
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


start_minikube()
{
	minikube start --vm-driver=virtualbox --disk-size=5000MB
	eval $(minikube docker-env)
}

install_build_metallb_secret()
{
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml > /dev/null
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml > /dev/null
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null
	printf "\n🚀 : Install [${Yellow}Metallb${Default_color}]\n"
	kubectl apply -f srcs/config/metallb.yaml > /dev/null
	printf "🔒 : Install [${Yellow}Secrets${Default_color}]\n"
	kubectl apply -f srcs/config/secret.yaml > /dev/null
}

kubernetes_build()
{
	services="ftps grafana nginx mysql wordpress phpmyadmin influxdb telegraf"
	for service in $services
	do
		printf "🐳 : kubernetes deployment [${Blue}$service${Default_color}]\n"
		kubectl apply -f srcs/$service/"$service"-deployment.yaml > /dev/null
	done
	printf "\n🎉 : ${Green}Images docker and kubernetes build${Default_color} 🐳\n"
}

docker_build()
{
	services="ftps grafana nginx mysql wordpress phpmyadmin influxdb telegraf"
	for service in $services
	do
		if [ $service == "ftps" ]; then
			printf "📦 : "
		elif [ $service == "grafana" ]; then
			printf "📈 : "
		elif [ $service == "nginx" ]; then
			printf "🎨 : "
		elif [ $service == "mysql" ]; then
			printf "🗃 : "
		elif [ $service == "wordpress" ]; then
			printf "🍱 : "
		elif [ $service == "phpmyadmin" ]; then
			printf "👥 : "
		elif [ $service == "influxdb" ]; then
			printf "🗃 : "
		elif [ $service == "telegraf" ]; then
			printf "⬆️ : "
		fi
		printf "docker build images   [${Green}$service${Default_color}]\n"
		docker build -t alpine_$service srcs/$service > /dev/null
		# load_animation $!
	done
}

main()
{
	start_minikube
	install_build_metallb_secret
	docker_build
	kubernetes_build
	# if [ $1 == "42Mac" ]; then
	printf "🤖 : Minikube ${Light_red}Dashboard${Default_color}\n"
	minikube dashboard
}

main "$1"