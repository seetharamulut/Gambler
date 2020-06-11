#! /bin/bash/ 

echo "Welcome To Gambling"

BASE_STAKE=100
MIN_BET_STAKE=1

declare -A dailyProfit

read -p "enter the percentage of stack won or lost to quit game  " quit_Percentage
quit_Stake=$(( ($quit_Percentage*$BASE_STAKE)/100 ))

read -p "enter num of days to play the game " days_Limit

function gamePerDay(){

	stake_Left=$BASE_STAKE

	while [ $stake_Left -lt $(( $BASE_STAKE+$quit_Stake )) ] && [ $stake_Left -gt $(($BASE_STAKE-$quit_Stake)) ]
	do
		case $(( $RANDOM%2 )) in

			0) stake_Left=$(( $stake_Left-1 )) ;;

			1) stake_Left=$(( $stake_Left+1 )) ;;
		esac
	done
}

function monthlyFeedback(){

	total_Profit=0

	for (( num_Of_Days=1; num_Of_Days<=$days_Limit; num_Of_Days++ ))
	do
		gamePerDay

		if [ $stake_Left -gt $BASE_STAKE ]
		then
			total_Profit=$(( $total_Profit+$(( $sake_Left-$BASE_STAKE )) ))
		else
			total_Profit=$(( $total_Profit-$(( $BASE_STAKE-$stake_Left )) ))
		fi

		dailyProfit[$num_Of_Days]=$total_Profit
	done

}


function luckyAndUnluckyDay(){

	monthlyFeedback

	echo "most luckiest day is : "
	for element in ${!dailyProfit[*]}
	do
		echo $element " : " ${dailyProfit[$element]}
	done | sort -n -k3 | tail -1

	echo "most unluckiest day is : "
        for element in ${!dailyProfit[*]}
        do
                echo $element " : " ${dailyProfit[$element]}
        done | sort -n -k3 | head -1

}

function continueNextGamble(){

	luckyAndUnluckyDay

	while [ $total_Profit -gt 0 ]
	do 
		luckyAndUnluckyDay

	done
}

continueNextGamble
