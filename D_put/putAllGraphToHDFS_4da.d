basedir=/home/jovyan/usr/amano/notebooks/data/rcoslogs/log
targetday=`date -d '4 day ago' '+%Y%m%d'`
#mkdir -p ${basedir}/D=$targetday
cd ${basedir}/D=${targetday}
pwd
ls
hdfs dfs -put T=ci/ckanedgelist.${targetday}.json log-graph/daily/ci/ckanedgelist.${targetday}.json
hdfs dfs -put T=4/_story/edgelist-4.${targetday}.json log-graph/daily/all/edgelist-4.${targetday}.json
#hdfs dfs -copyToLocal /user/rcoslog/logs/log-${targetday}.rcoslog000[123].log ./
#chmod -R 777 ${basedir}/D=$targetday
