
HOST_PATH="$HOME"
HOST_USER="$USER"
CMD_NAME=$(basename $0)
IMG_NAME=$(basename $IMAGE_NAME)
RUN_NAME="DOCKER-$USER-$IMG_NAME"
DOCKER_PATH="/opt/$RUN_NAME"

usage(){
echo "Usage: run.sh Command

Commands:
    stop        Stop Docker ID($RUN_NAME)
"
}

check_image(){
	local chk=$(sudo docker images | grep $IMAGE_NAME)
	local exist="1"
	
	[ "x$chk" == "x" ] && exist="0"

	echo "$exist"
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

check_docker_ps_exit(){
    local chk=$(check_docker_ps $1 Exited)
    echo "$chk"
}

stop_docker_ps(){
    echo "sudo docker stop $1"
    sudo docker stop $1
}

rm_docker_ps(){
    echo "sudo docker rm $1"
    sudo docker rm $1
}

run_deamon(){
    echo "sudo docker run -d -t -e DK_USER=$HOST_USER -e DK_MOUNT_PATH=$DOCKER_PATH --name $RUN_NAME -v $HOST_PATH:$DOCKER_PATH $IMAGE_NAME /bin/bash"
	sudo docker run -d -t -e DK_USER=$HOST_USER -e DK_MOUNT_PATH=$DOCKER_PATH -d --name $RUN_NAME -v $HOST_PATH:$DOCKER_PATH $IMAGE_NAME /bin/bash
}

run_enter(){
    echo "sudo docker-enter $RUN_NAME /bin/bash"
    sudo docker-enter $RUN_NAME /bin/bash
}

run_auto(){
    local chk="0"
    chk=$(check_docker_ps_exit $RUN_NAME)

    if [ "$chk" == "1" ]; then
        echo "MSG: $RUN_NAME is exited then remove and restart"
        rm_docker_ps "$RUN_NAME"
        chk="0"
    else
		chk=$(check_docker_ps $RUN_NAME)
    fi

    [ "$chk" == "0" ] && run_deamon
    run_enter
}

main(){
    local cmd="$1"
    local chk="0"

    [ -z $cmd ] && {
        run_auto
        exit 0
    }

    case "$cmd" in

        "stop")
            chk=$(check_docker_ps $RUN_NAME)
            if [ "$chk" == "1" ]; then
                stop_docker_ps "$RUN_NAME"
                rm_docker_ps "$RUN_NAME"
            fi
        ;;

        *)
            usage
        ;;
    esac
}
