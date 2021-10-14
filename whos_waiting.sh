# A script that calculates kvicksand logfile waittime and prints User-Agent in csv format
re='^[0-9]+$'
startt=$(head -n 1 $1)
stopt=$(tail -n 1 $1)
if [[ $startt =~ $re ]] && [[ $stopt =~ $re ]] ; then
	echo \"$(grep User-Agent $1| cut -f 2- -d ' ')\", \"$(($stopt - $startt))\"
fi
