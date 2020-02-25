brew cask install virtualbox
brew install kubectl
brew install minikube
mv ./minikube /goinfre/jereligi
cd /goinfre/jereligi
ln -s /goinfre/jereligi/.minikube /Users/jereligi/.minikube
minikube start --vm-driver=virtualbox --disk-size=5000MB


