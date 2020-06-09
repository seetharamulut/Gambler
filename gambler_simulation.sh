#! /bin/bash/

echo "Welcome To Gambling"

BASE_STAKE=100
MIN_BET_STAKE=1

read -p "enter the percentage of stack won or lost to quit game  " Quit_Percentage
Quit_Stake=$(( ($Quit_Percentage*$BASE_STAKE)/100 ))

Stake_Left=$BASE_STAKE

while [ $Stake_Left -lt $(( $BASE_STAKE+$Quit_Stake )) ] && [ $Stake_Left -gt $(($BASE_STAKE-$Quit_Stake)) ]
do
	case $(( $RANDOM%2 )) in

		0) Stake_Left=$(( $Stake_Left-1 )) ;;
		1) Stake_Left=$(( $Stake_Left+1 )) ;;
	esac
done

echo "player quit the game with stake reamaining : "$Stake_Left
