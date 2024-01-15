basedir='/home/amano/notebooks/data/rcoslogs/log/'
while read dir
  do cd $basedir$dir; pwd; ./exec-preproc;
done < /home/amano/notebooks/data/rcoslogs/log/exec_command/monthly/202310/dirs
