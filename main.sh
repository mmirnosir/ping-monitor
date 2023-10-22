# Ping monitor tool
#
#
# Description:
# Checking connection with a host through ping calls.
#
# Usage:
# ./main.sh [file] [seconds]
#
#



while true
do
	clear
	echo 'Scanning has started...'
	echo '-----------------------------------------------------'
	while read -r ipadd
	do
		ipadd=$(echo "$ipadd" | sed 's/\r//')
		ping -c 1 "$ipadd" | egrep '(Destionation host unreachable|100%)' &> /dev/null
		if (( "$?" == 0 ))
		then
			tput setaf 1
			echo "Host $ipadd not found $(date)" | tee -a monitorlog.txt
			tput setaf 7
		fi

	done < "$1"

	echo ""
	echo "done."

	for ((i="$2"; i > 0; i--))
	do
		tput cup 1 0
		echo "Status: Next scan in $i seconds"
		sleep 1

	done
done
