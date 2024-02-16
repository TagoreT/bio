#!/bin/bash

# set -o errexit
# set -o pipefail
# set -o nounset
#set -o xtrace

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

is_darwin() {
	case "$(uname -s)" in
	*darwin* ) true ;;
	*Darwin* ) true ;;
	* ) false;;
	esac
}


function install_fun() {
  echo "this system has not installed docker"
  echo "starting install docker and docker-compose"
  # install docker in China, using Aliyun mirror
  # curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
  # set aliyun image accelerator
  # sudo mkdir -p /etc/docker
  # sudo tee /etc/docker/daemon.json <<-'EOF'
  # {
  #   "registry-mirrors": ["https://cj9kwv26.mirror.aliyuncs.com"]
  # }
  # EOF
  
	if is_darwin; then
		echo
		echo "ERROR: Unsupported operating system 'macOS'"
		echo "Please get Docker Desktop from https://www.docker.com/products/docker-desktop"
		echo
		exit 1
	fi
  
  
  
  if ! command_exists curl; then
    echo "is installing curl"
    if command_exists apt-get; then
      apt-get install -y curl
    else
      echo "apt-get command not found"
    fi
  fi
  # install docekr in other country, using defaul mirror
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo systemctl daemon-reload
  sudo systemctl restart docker
  if ! command_exists docker;then
		echo "docker has not been installed successfully"
		exit 1
  fi

  # docker install check
  docker version

  # install docker compose
  sudo curl -L https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  if ! command_exists docker-compose;then
		echo "docker-compose has not been installed successfully"
		exit 1
  fi

  sudo chmod +x /usr/local/bin/docker-compose
  # pip install  docker-compose

  # docker-compose install check
  docker-compose --version
}

function easy_timepro_install() {
  #docker=$(rpm -qa | grep "docker-ce")
  if [ $UID -ne 0 ]; then
 	echo Non root user. Please run as root.
	exit 1
  else
 	echo Root user
  fi

  if command_exists docker && command_exists docker-compose; then
    echo "docker has been installed"
	
    docker version
    sudo systemctl start docker.service
    sudo systemctl enable docker.service
  else
    install_fun
  fi

  echo "building images and start"
  docker-compose build
  docker-compose up -d
}

function easy_timepro_status() {
  echo "this is docker-compose sevicie status"
  docker-compose ps
  # echo "this is docker-compose service detail"
  # docker-compose -f production.yml top
}

function easy_timepro_start() {
  echo "starting docker-compose"
  docker-compose start
  echo "started docker-compose"
}

function easy_timepro_stop() {
  echo "stoping docker-compose"
  docker-compose stop
  echo "stopped docker-compose"
}

# Initialization step
action=$1
# init_set
# echo ${action}
[ -z $1 ]
case "$action" in
install)
  easy_timepro_install
  ;;
status)
  easy_timepro_status
  ;;
start)
  easy_timepro_start
  ;;
stop)
  easy_timepro_stop
  ;;
restart)
  easy_timepro_stop
  easy_timepro_start
  ;;
*)
  echo "Arguments error! [${action}]"
  echo "Usage: $(basename $0) [install|status|start|stop|restart]"
  ;;
esac
