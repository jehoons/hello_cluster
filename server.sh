#!/bin/bash 
SERVERS=$(seq 1 3)
IMAGE=hello-cluster
CONTAINER=HelloClusterNode
build() { 
    docker build . -t $IMAGE
}
shell() { 
    docker exec -it ${CONTAINER} bash 
}
create_network() {
    docker network create -d bridge mybridge
} 
start() {
    for ID in $SERVERS
    do
        docker run -d --net mybridge -it --rm --name ${CONTAINER}_${ID} $IMAGE & 
        # echo ${id} 
    done
    wait 
} 
stop() {
    for ID in $SERVERS
    do
        docker stop ${CONTAINER}_${ID} &
    done
    wait 
} 
ping() {
    docker exec -it HelloClusterNode_1 ping HelloClusterNode_3
}

case "$1" in
    shell)
        shell 
        ;; 
    build)
        build $2
        ;;
    start)
        start $2
        ;;
    stop)
        stop
        ;;
    restart)
        stop & 
        echo "wait stoping ..."
        wait 
        start $2
        ;; 
    start) 
        start
        ;;
    stop) 
        stop
        ;;
    create_network) 
        create_network
        ;;
    ping) 
        ping 
        ;;

    *)
        echo 
        echo "Usage $0 shell"
        echo "Usage $0 build"
        echo "Usage $0 start"
        echo "Usage $0 stop"
        echo "Usage $0 restart"
        echo 
esac
