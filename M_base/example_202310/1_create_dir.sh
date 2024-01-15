basedir='/home/amano/notebooks/data/rcoslogs/log/'
while read dir; do mkdir ${basedir}${dir}; done < ./dirs
