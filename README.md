# Ft_services - [@42Born2code](https://www.youtube.com/watch?time_continue=88&v=eawhnhTO2oY&feature=emb_logo)
![](https://www.combell.com/fr/blog/files/Kubernetes-Combell-750x256.jpg)
---

Ft_services is an individual project at [42](https://www.42.fr/42-network/) about System Administration, using Kubernetes to virtualize a network and implement a production environment

## Introduction
Ft_services is a project where we have to deploy several services *(Nginx, Wordpress, PhpMyAdmin, Mysql (Mariadb), Grafana, Influxdb, Telegraf, FTPS, SSH)*, via [kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/), each service will have to run in a different pod, all services should be build with __Alpine Linux__ for performance reasons, they will all have to have a __Dockerfile__. 🐳


__Project duration__ : about 3 weeks

*Tips and good methodology to do the project at the bottom of the readme*


## What is [Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/#:~:text=Minikube%20is%20a%20tool%20that,it%20day%2Dto%2Dday.) in [Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/) ☸
For this project we use Minikube.
Minikube is a tool that makes it easy to run Kubernetes locally. Minikube runs a single-node Kubernetes cluster inside a Virtual Machine (VM) on your laptop for users looking to try out Kubernetes or develop with it day-to-day


## What is [Docker](https://docs.docker.com/get-started/overview/) 🐳
Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infrastructure in the same ways you manage your applications. By taking advantage of Docker’s methodologies for shipping, testing, and deploying code quickly, you can significantly reduce the delay between writing code and running it in production.

## Application Details 📱

| Name		| Description	|
|-----------|---------------|
| __FTPS__		| Secure file server by SSL protocol for the encryption of transfers. |
| __Nginx__		| Web server allowing to host a website. |
| __Wordpress__	| Wordpress website allowing to easily create a web page or blog. |
| __MariaDB__ | Database used by Wordpress to store its data |
| __PhpMyAdmin__ |Database administration website |
| __Grafana__ | Monitoring website for all the services deployed |
| __InfluxDB__ | Temporal database used to store the measurements of the services, this is where Grafana takes the data |
| __Telegraf__ | Information gathering software to acquire service data to store them in InfluxDB |



## Installation 🖥
Use the `setup.sh` script to build the docker images and deploye kubernetes.

```bash
# Use the setup.sh script with an argument, according to your environment
sh setup.sh 42Mac
# or
sh setup.sh 42Linux
```

## Tips command
__Docker basics command__  🐳
```bash

# build a docker image from a Dockerfile
docker build -t <name image> <path Dockerfile>
exemple : docker build -t alpine_nginx /srcs/

# Run instance of docker image
docker run -it <name image>

# Run instance of docker image and expose port
docker run -it -p <port:port> <name image>
exemple : docker run -it -p 80:80 alpine_nginx

# See all images
docker images

# See running containers
docker ps

# Inspect a container
docker inspect <ID container>

# Kill a container
docker kill <ID container>

# Add environnement variable in Docker
docker run -it -e <name_of_env_var=value> <name image>
exemple : docker run -it -e USER=jereligi alpine_nginx

# donner une ip a un container
exemple : docker run --network=“bridge” -t alpine_wordpress .

# Stop a container
docker stop

# Delete a image
docker image rm <ID iamge>
```
__[Docker documentation](https://docs.docker.com/)__

__Kubernetes basics command__ ☸
```bash
Kubernetes

# Create a pod from YAML file
kubectl apply -f <file.yaml>
kubectl create -f <file.yaml>

# Get shell in a pod
kubectl exec -t -i <pod_name> -- /bin/bash

# Get the pod
kubectl get pods

# Get the deployment
kubectl get deployment

# Get the service
kubectl get service

# Describe the pod
kubectl describe <pod_name> 

# Delete a YAML file
kubectl delete -f <file.yaml>

# Delete deployment
kubectl delete deployment <name_deployment>

# Launch minikube dashboard
minikube dashboard

# Connects to the service IP
minikube service <nom du service> --url

# ⚠️ Kill a process directly inside the pod | very important to check if the services restart correctly after a crash
kubectl exec deploy/<name_deployment> -- pkill <APP>

# Launch minikube by choosing are driver
minikube start --vm-driver=virtualbox
minikube start --vm-driver=docker
minikube start --vm-driver=none

# Reset Minikube VM
minikube delete
```
__[Kubernetes documentation](https://kubernetes.io/docs/home/)__

## Tips project

> ⚠️ **Warning**: Don't copy/paste code you don't understand: it's bad for you, and for the school. I have put my login in a lot of files to encourage you doing your own version. Have fun !


__*Methodological advice to carry out the project*__

1. Creation of a first version of all Docker images to test their proper functioning one by one locally.
2. Development of the first version of the script to check the dependencies and install them if needed, notably under 42Mac.
For the 42VM, no dependencies are necessary, but some configuration at the ip level, as well as changing the minikube driver [virtualbox -> docker].
3. Writing .yaml files to deploy and test Docker images in kubernetes.
4. Installation of the Loadbalancer (Metallb) to be able to access the service as a customer.
5. Automation of Docker image builds in the bash script.
6. Automation of deployments in minikube in the bash script.
7. Test your program regularly this is important !
8. Checking the health status of services with [livenessprobe][https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/]
9. Last script settings
10. Be proud of your project and of yourself

## Project documentation 📚

- [Google is your best friend](https://www.google.com/) 
but here are some basic installation documentation
- [Kubernetes Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Metallb](https://metallb.universe.tf/installation/)
- [Nginx](https://wiki.alpinelinux.org/wiki/Nginx)
- [MYSQL](https://wiki.alpinelinux.org/wiki/MariaDB)
- [Wordpress](https://wiki.alpinelinux.org/wiki/WordPress)
- [Run Wordpress with PHP server](https://medium.com/@petehouston/use-the-built-in-php-server-in-wordpress-development-d9927ce19c44)
- [PhpMyAdmin](https://wiki.alpinelinux.org/wiki/PhpMyAdmin)
- [Grafana](https://grafana.com/docs/grafana/latest/installation/debian/)
- [Influxdb](https://docs.influxdata.com/influxdb/v1.7/introduction/installation/)
- [Telegraf](https://portal.influxdata.com/downloads/)
- [FTPS](https://www.opensourceforu.com/2015/03/set-up-an-ftps-server-in-linux/)
- [SSH](https://wiki.alpinelinux.org/wiki/Setting_up_a_ssh-server)

## Contributing, Question or suggestions ?
__42Slack :__ __*jereligi*__

__42Intra :__ [jereligi](https://profile.intra.42.fr/users/jereligi)

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate.


Thanks for reading this read me, advice or corrections are welcome




