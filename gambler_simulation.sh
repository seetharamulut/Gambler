#! /bin/bash/ 

echo "Welcome To Gambling"

BASE_STAKE=100
MIN_BET_STAKE=1

declare -A DailyProfit

read -p "enter the percentage of stack won or lost to quit game  " Quit_Percentage
Quit_Stake=$(( ($Quit_Percentage*$BASE_STAKE)/100 ))

read -p "enter num of days to play the game " Days_Limit

function GamePerDay(){

	Stake_Left=$BASE_STAKE

	while [ $Stake_Left -lt $(( $BASE_STAKE+$Quit_Stake )) ] && [ $Stake_Left -gt $(($BASE_STAKE-$Quit_Stake)) ]
	do
		case $(( $RANDOM%2 )) in

			0) Stake_Left=$(( $Stake_Left-1 )) ;;

			1) Stake_Left=$(( $Stake_Left+1 )) ;;
		esac
	done
}

function MonthlyFeedback(){

	Total_Profit=0

	for (( num_of_days=1; num_of_days<=$Days_Limit; num_of_days++ ))
	do
		GamePerDay

		if [ $Stake_Left -gt $BASE_STAKE ]
		then
			Total_Profit=$(( $Total_Profit+$(( $Stake_Left-$BASE_STAKE )) ))
		else
			Total_Profit=$(( $Total_Profit-$(( $BASE_STAKE-$Stake_Left )) ))
		fi

		DailyProfit[$num_of_days]=$Total_Profit
	done

}


function LuckyAndUnluckyDay(){

	MonthlyFeedback

	echo "most luckiest day is : "
	for element in ${!DailyProfit[*]}
	do
		echo $element " : " ${DailyProfit[$element]}
	done | sort -n -k3 | tail -1

	echo "most unluckiest day is : "
        for element in ${!DailyProfit[*]}
        do
                echo $element " : " ${DailyProfit[$element]}
        done | sort -n -k3 | head -1

}

function ContinueNextGamble(){

	LuckyAndUnluckyDay

	while [ $Total_Profit -gt 0 ]
	do 
		LuckyAndUnluckyDay

	done
}

ContinueNextGamble
