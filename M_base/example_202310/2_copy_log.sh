basedir='/home/amano/notebooks/data/rcoslogs/log/'
source ~/.hdfs
#hdfs dfs -ls logs/log-202310*log
while read dir
  do hdfs dfs -copyToLocal logs/log-${dir#D=}.rcoslog000[123].log $basedir${dir}/
done < dirs
