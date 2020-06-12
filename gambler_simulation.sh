#! /bin/bash/ 

echo "Welcome To Gambling"

BASE_STAKE=100
MIN_BET_STAKE=1

declare -A dailyProfit

read -p "enter the percentage of stack won or lost to quit game  " quitPercentage
quitStake=$(( ($quitPercentage*$BASE_STAKE)/100 ))

read -p "enter num of days to play the game " daysLimit

function gamePerDay(){

	stakeLeft=$BASE_STAKE

	while [ $stakeLeft -lt $(( $BASE_STAKE+$quitStake )) ] && [ $stakeLeft -gt $(($BASE_STAKE-$quitStake)) ]
	do
		case $(( $RANDOM%2 )) in

			0) stakeLeft=$(( $stakeLeft-1 )) ;;

			1) stakeLeft=$(( $stakeLeft+1 )) ;;
		esac
	done
}

function monthlyFeedback(){

	totalProfit=0

	for (( numOfDays=1; numOfDays<=$daysLimit; numOfDays++ ))
	do
		gamePerDay

		if [ $stakeLeft -gt $BASE_STAKE ]
		then
			totalProfit=$(( $totalProfit+$(( $sakeLeft-$BASE_STAKE )) ))
		else
			totalProfit=$(( $totalProfit-$(( $BASE_STAKE-$stakeLeft )) ))
		fi

		dailyProfit[$numOfDays]=$totalProfit
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

	while [ $totalProfit -gt 0 ]
	do 
		luckyAndUnluckyDay

	done
}

continueNextGamble
