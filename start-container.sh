#!/bin/bash

LocalPath=${1:-'/Users/bit/Documents/DockerFileSharing/hadoopjob'}
RemotePath=${2:-'/myjob'}
# the default node number is 5
N=5

sudo docker network create --driver=bridge hadoop

# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                -p 9000:9000 \
                -v $LocalPath:$RemotePath \
                --name hadoop-master \
                --hostname hadoop-master \
                chaaaa/hadoop-cluster-dockerfile &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                chaaaa/hadoop-cluster-dockerfile &> /dev/null
	i=$(( $i + 1 ))
done

# get into hadoop master container
sudo docker exec -it hadoop-master bash
