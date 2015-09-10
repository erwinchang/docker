#
HOST_PATH="$HOME"
HOST_USER="$USER"
CMD_NAME=$(basename $0)
IMG_NAME=$(basename $IMAGE_NAME)
RUN_NAME="$USER-$IMG_NAME"
DOCKER_PATH="/opt/$RUN_NAME"

docker_ssh_login(){
	local ps_name="$1"
	local ssh_ip="0000"
	local ssh_port=""
	local chk_ps22=$(check_docker_ps $1 "22/tcp")
	echo "docker_ssh_login: $ps_name,$chk_ps22"
# ssh -p $ssh_port root@ssh_ip

	[ "$chk_ps22" == "0" ] && {
		echo "docker_ssh_login: error, docker can't found $ps_name"
		return
	}

	ssh_port=$(sudo docker ps -a | grep $ps_name | awk -F"0.0.0.0:" '{ print $2}' | awk -F"->22" '{print $1}')
	ssh_ip=$(ifconfig docker0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')

	[ "x$ssh_port" == "x" -o "x$ssh_ip" == "x" ] && {
		echo "docker_ssh_login: error, docker sshd port can't found"
		return
	}

	ssh -p $ssh_port root@$ssh_ip
}

check_docker_ps(){
	local chk="0"
	local arg1="$1"
	local arg2="$2"
	local exist="1"

	if [ "x$arg2" == "x" ]; then
		chk=$(sudo docker ps -a | grep $arg1)
	else
		chk=$(sudo docker ps -a | grep $arg1 | grep $arg2)
	fi
	
	[ "x$chk" == "x" ] && exist="0"

	echo "$exist"
}

usage(){
echo "Usage: build.sh COMMAND [arg...]

Commands:
    docker     	Build an image from a Dockerfile
    tty         Run $IMAGE as tty mode
    ssh         Run $IMAGE as ssh mode
    stop        Stop Docker ID($RUN_NAME)
    login       Used ssh auto login to docker image($RUN_NAME)
"
}

build_dockerfile(){
	sudo docker build -t "$IMAGE_NAME" .
}

run_tty(){
	sudo docker run -t -i -v $HOST_PATH:$DOCKER_PATH --name $RUN_NAME $IMAGE_NAME /bin/bash
}

check_image(){
	local chk=$(sudo docker images | grep $IMAGE_NAME)
	local exist="1"
	
	[ "x$chk" == "x" ] && exist="0"

	echo "$exist"
}

echo_image_isnt_exit(){
echo "
   docker image isn't exist ($IMAGE_NAME)
"
}

run_ssh(){
	sudo docker run -d -P --name $RUN_NAME -v $HOST_PATH:$DOCKER_PATH $IMAGE_NAME
	sudo docker port $RUN_NAME 22
}

function_main(){
	local cmd="$1"
	local chk="0"
	
	case "$cmd" in
		"docker")
			chk=$(check_image)
			if [ "$chk" == "1" ]; then
				echo ""
				echo "   docker image is exist ($IMAGE_NAME) "
				echo ""
				echo "   ex. sudo docker build -t $IMAGE_NAME ."
			else
				echo "   docker build image.."
				build_dockerfile
			fi
		;;
		
		"tty")
			chk=$(check_image)
			[ "$chk" == "0" ] && {
				echo_image_isnt_exit
				return
			}

			chk=$(check_docker_ps $RUN_NAME)
			if [ "$chk" == "1" ]; then
				echo ""
				echo "   tty is exist ($RUN_NAME)"
				echo ""
				echo "   ex. sudo docker run -t -i -v $HOST_PATH:$DOCKER_PATH --name $RUN_NAME $IMAGE_NAME /bin/bash "
			else
				echo "tty running .."
				run_tty
			fi
		;;
		
		"ssh")
			chk=$(check_image)
			[ "$chk" == "0" ] && {
				echo_image_isnt_exit
				return
			}

			chk=$(check_docker_ps $RUN_NAME)
			if [ "$chk" == "1" ]; then
				echo ""
				echo "   ssh is exist ($RUN_NAME)"
				echo ""
				echo "   ex. sudo docker run -d -P --name $RUN_NAME -v $HOST_PATH:$DOCKER_PATH $IMAGE_NAME"
				echo "       sudo docker port $RUN_NAME 22"
			else
				echo "ssh running .."
				run_ssh
			fi
		;;
		"stop")
			chk=$(check_docker_ps $RUN_NAME)
			if [ "$chk" == "1" ]; then
				echo "sudo docker stop $RUN_NAME"
				sudo docker stop $RUN_NAME
				echo "sudo docker rm $RUN_NAME"
				sudo docker rm $RUN_NAME
				echo ""
				echo "   docker stop $RUN_NAME success"
				echo ""

			else
				echo ""
				echo "   docker $RUN_NAME isn't running"
				echo ""
			fi
		;;
		"login")
			docker_ssh_login "$RUN_NAME"
		;;

		*)
			usage
		;;
	esac
}