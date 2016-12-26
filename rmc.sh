
echo "rm hadoop-master container..."
sudo docker rm -fv hadoop-master

i=1
while [ $i -lt 5 ]
do
  echo "rm hadoop-slave${i} container..."
	sudo docker rm -fv hadoop-slave$i
	i=$(( $i + 1 ))
done
