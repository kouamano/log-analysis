basedir=/home/jovyan/usr/amano/notebooks/data/rcoslogs/log
targetday=`date -d '2 day ago' '+%Y%m%d'`
mkdir -p ${basedir}/D=$targetday
cd ${basedir}/D=$targetday
hdfs dfs -copyToLocal /user/rcoslog/logs/log-${targetday}.rcoslog000[123].log ./
chmod -R 777 ${basedir}/D=$targetday
