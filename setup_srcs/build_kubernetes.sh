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
Orange="\e[38;5;202m"			#--------- Orange color
Blue="\e[34m"			#--------- Blue color
Default_color="\e[39m"	#--------- Default color

################################################################################


start_minikube()
{
	minikube delete
	minikube start --vm-driver=virtualbox --disk-size=5000MB
	eval $(minikube docker-env)
}

install_addons_minikube()
{
	minikube addons enable metrics-server
	minikube addons enable logviewer
}

run_minikube_dashboard()
{
	printf "\n🤖 : Minikube ${Light_red}Dashboard${Default_color}\n"
	sleep 2
	minikube dashboard
	sleep 2
	minikube dashboard
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
			printf "🗃  : "
		elif [ $service == "wordpress" ]; then
			printf "🍱 : "
		elif [ $service == "phpmyadmin" ]; then
			printf "👥 : "
		elif [ $service == "influxdb" ]; then
			printf "🗃  : "
		elif [ $service == "telegraf" ]; then
			printf "⬆️  : "
		fi
		printf "docker build images   [${Green}$service${Default_color}]\n"
		docker build -t alpine_$service srcs/$service > /dev/null
		# load_animation $!
	done
}

display_service()
{
	printf "\n🎉 : FT_SERVICES ${Green}READY${Default_color}\n"
	echo " ---------------------------------------------------------------------------------------"
	printf "| ${Blue}Wordpress${Default_color}	 | user: admin     | password: admin    | ip: http://"
	kubectl get svc | grep wordpress-service | cut -d " " -f 11,12,13 | tr -d "\n" | tr -d " "
	printf ":5050  |\n"
	echo " ---------------------------------------------------------------------------------------"
	printf "| ${Yellow}PhpMyAdmin${Default_color}     | user: wp_user   | password: password | ip: http://"
	kubectl get svc | grep phpmyadmin-service | cut -d " " -f 10,11,12 | tr -d "\n" | tr -d " "
	printf ":5000  |\n"
	echo " ---------------------------------------------------------------------------------------"
	printf "| ${Green}Ftps${Default_color}           | user: ftps_user | password: password | ip: "
	kubectl get svc | grep ftps-service | cut -d " " -f 15,16,17,18 | tr -d "\n" | tr -d " "
	printf ":21           |\n"
	echo " ---------------------------------------------------------------------------------------"
	printf "| ${Light_red}Grafana${Default_color}        | user: admin     | password: admin    | ip: http://"
	kubectl get svc | grep grafana-service | cut -d " " -f 13,14,15 | tr -d "\n" | tr -d " "
	printf ":3000  |\n"
	echo " ---------------------------------------------------------------------------------------"
	printf "| ${Orange}Nginx${Default_color}          | user: ssh_user  | password: password | ip: https://"
	kubectl get svc | grep nginx-service | cut -d " " -f 15,16,17 | tr -d "\n" | tr -d " "
	printf ":443  |\n"
	echo " ---------------------------------------------------------------------------------------"
}

main()
{
	start_minikube
	install_build_metallb_secret
	docker_build
	kubernetes_build
	# if [ $1 == "42Mac" ]; then
	# 	sed 's/-opasv_address=192.168.99.2/-opasv_address=192.168.99.2/' /srcs/ftps/setup_ftps.sh > /srcs/ftps/setup_ftps.sh
	display_service
	install_addons_minikube
	run_minikube_dashboard
}

main "$1"