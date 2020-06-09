#! /bin/bash/

echo "Welcome To Gambling"

BASE_STAKE=100
MIN_BET_STAKE=1
Total_Stake_won=0
Total_Stake_Lost=0

read -p "enter the percentage of stack won or lost to quit game  " Quit_Percentage
Quit_Stake=$(( ($Quit_Percentage*$BASE_STAKE)/100 ))

read -p "enter num of days to play the game " Days_Limit

function GamePerDay(){

	Stake_Left=$BASE_STAKE

	while [ $Stake_Left -lt $(( $BASE_STAKE+$Quit_Stake )) ] && [ $Stake_Left -gt $(($BASE_STAKE-$Quit_Stake)) ]
	do
		case $(( $RANDOM%2 )) in

			0) Stake_Left=$(( $Stake_Left-1 ))
			   Total_Stake_Lost=$(( $Total_Stake_Lost+1 )) ;;

			1) Stake_Left=$(( $Stake_Left+1 ))
			   Total_Stake_Won=$(( $Total_Stake_Won+1 )) ;;
		esac
	done


}

function MonthlyFeedback(){

	for (( num_of_days=1; num_of_days<=$Days_Limit; num_of_days++ ))
	do
		GamePerDay 

		if [ $Stake_Left -gt $BASE_STAKE ]
		then
			echo "amount won on day "$num_of_days" is :"$(( $Stake_Left-$BASE_STAKE ))
		else
			echo "amount lost on day "$num_of_days" is :"$(( $BASE_STAKE-$Stake_Left ))
		fi

	done

}

MonthlyFeedback

