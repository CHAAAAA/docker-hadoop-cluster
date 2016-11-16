# 利用Docker创建hadoop集群

原文在此 http://kiwenlau.com/2016/06/12/160612-hadoop-cluster-docker-update/

这个项目的问题是增加节点的时候需要在本地build，但是本地build的时候`apt-get update`会出错，即使更换国内的源也不行。所以可以通过DockerHub远程构建，然后直接`pull`到本地，然后再本地启动docker容器。

config文件夹下的配置文件会传入集群，可以通过本地更改后提交到GitHub，然后在DockerHub中重新构建。

本地启动docker镜像如下：

* `./start-container.sh` 可以带参数，第一个参数是本地挂载的目录，第二个参数是挂载的目标目录
* 进入hadoop集群（默认进入）
* `./start-hadoop.sh` 启动hadoop
* 测试 `./run-wordcount.sh`
* 对于自己的作业，可以进入到挂载的目录执行。这样可以将处理数据和程序通过本地路径传入hadoop集群
