#! /bin/bash/

echo "Welcome To Gambling"

BASE_stakE=100
MIN_BET_STAKE=1

case $(( $RANDOM%2 )) in

	0) echo "player lost the bet" ;;
	1) echo "player won the bet" ;;
esac
