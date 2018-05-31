#!/bin/bash
# write for :
#	zookeeper cluster run or stop  or status
#babysafer at fq, 20170301

#get the zk cluster  host or ip and port
serverIP=( `cat $ZOOKEEPER_HOME/conf/zoo.cfg | grep server  | awk -F = '{print $2}' | awk -F : '{ print $1}'`) 
CLIENT_PORT=`cat $ZOOKEEPER_HOME/conf/zoo.cfg | grep clientPort | awk -F = '{print $2}'`

# start|stop|status functions
start()
{
for host in ${serverIP[*]}
do
	echo  -e "\033[32m................ $host:$CLIENT_PORT..starting................. \033[0m"
        ssh $host 'source ~/.bash_profile;$ZOOKEEPER_HOME/bin/zkServer.sh start'
done
}
stop()
{
read -p "are you sure to stop all zookeeper cluster? [y or n]"  Y_or_N
echo $Y_or_N
if [[ $Y_or_N = y ]] ; then
for host in ${serverIP[*]}
do
	echo  -e "\033[31m..............$host:$CLIENT_PORT.stoping.................. \033[0m"
        ssh $host 'source ~/.bash_profile;$ZOOKEEPER_HOME/bin/zkServer.sh stop'
done
else 
	exit
fi
}
status()
{
for host in ${serverIP[*]}
do
	echo  -e "\033[34m=============== $host:$CLIENT_PORT status =========================== \033[0m"
        ssh $host 'source ~/.bash_profile;$ZOOKEEPER_HOME/bin/zkServer.sh status'
done
}


if [[ $1 = "status" ]] ; then
    status
elif [[ $1 = "stop" ]] ; then
    stop
elif [[ $1 = "start" ]] ; then
    start
else
	echo -e "\033[31m which do you want to do, start|stop|status \033[0m"
	echo -e "\033[31m please enter start|stop|status \033[0m"
fi





