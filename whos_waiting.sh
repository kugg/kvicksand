# A script that calculates kvicksand logfile waittime and prints User-Agent in csv format
intre='^[0-9]+$'
ipre='^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$'
startt=$(head -n 1 $1)
stopt=$(tail -n 1 $1)
ipaddr=$(sed '2q;d' $1)
verb=$(sed '3q;d' $1)
if [[ $ipaddr =~ $ipre ]] && [[ $startt =~ $intre ]] && [[ $stopt =~ $intre ]] ; then
        echo \"$(grep User-Agent $1| cut -f 2- -d ' ')\", \"$(($stopt - $startt))\",\"$ipaddr\",\"$verb\"
fi
