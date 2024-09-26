basedir=/home/jovyan/usr/amano/notebooks/data/rcoslogs/log
targetday=`date -d '2 day ago' '+%Y%m%d'`
mkdir -p ${basedir}/D=$targetday
cd ${basedir}/D=$targetday
str=`hdfs dfs -copyToLocal /user/rcoslog/logs/log-${targetday}.rcoslog*.log ./ 2>&1`
chmod -R 777 ${basedir}/D=$targetday
echo $str

ret=0
if [[ $str =~ "No such" ]]; then
  echo "source file does not exist"
  ret=1
fi

exit $ret
