#!/bin/sh

TABLE=('.' '.' '.' '.' '.' '.' '.' '.' '.' )
MARKED_FIELD=0
CURRENT_FIELD=0
SIGN='X'
WINNER=0

function printTable() {
    printf "\n\n"

    if [ $SIGN = 'X' ]
    then
            echo "Player 1 turn"
        else
            echo "Player 2 turn"
    fi

    printf "\n"


    for i in {0..2}
    do
        for j in {0..2}
            do
                CURRENT_FIELD=$((3*i + j))
                if [ $CURRENT_FIELD -eq $MARKED_FIELD ]
                then
                    printf "["
                fi
                printf "%s" ${TABLE[3*$i + $j]}
                if [ $CURRENT_FIELD -eq $MARKED_FIELD ]
                then
                    printf "]"
                fi
                printf "\t"
            done
            printf "\n"
    done
}

function move() {
    if [ $key = 's' ]
    then
        MARKED_FIELD=$(($MARKED_FIELD+3))
    fi
    if [ $key = 'w' ]
    then
        MARKED_FIELD=$(($MARKED_FIELD-3))
    fi
    if [ $key = 'a' ]
    then
        MARKED_FIELD=$(($MARKED_FIELD-1))
    fi
    if [ $key = 'd' ]
    then
        MARKED_FIELD=$(($MARKED_FIELD+1))
    fi
}

function placeSign() {
        if [ ${TABLE[$MARKED_FIELD]} = '.' ]
        then
            TABLE[MARKED_FIELD]=$SIGN
            if [ $SIGN = 'X' ]
            then
                SIGN='O'
            else
                SIGN='X'
            fi
        fi
}

function readKey() {
    read -s -n 1 key

    move

    if [ $key = 'p' ]
    then
        placeSign
    fi

    if [ $MARKED_FIELD -lt 0 ]
    then
        MARKED_FIELD=0
    fi

    if [ $MARKED_FIELD -gt 8 ]
    then
        MARKED_FIELD=8
    fi
}

checkLine() {
  if [ ${TABLE[$1]} != "." ] && [ ${TABLE[$1]} == ${TABLE[$2]} ] && [ ${TABLE[$2]} == ${TABLE[$3]} ]
    then
        if [ ${TABLE[$1]} = "X" ]
        then
            WINNER=1
            else
            WINNER=2
        fi
  fi
}

checkForWin() {
  checkLine 0 3 6
  checkLine 1 4 7
  checkLine 2 5 8
  checkLine 0 1 2
  checkLine 3 4 5
  checkLine 6 7 8
  checkLine 0 4 8
  checkLine 2 4 6
}

echo "Welcome to TIC TAC TOE!"
echo "Use W S A D to move"
echo "Use P to place sign"
while [ $WINNER -eq 0 ]
do
printTable
readKey
checkForWin
done
echo "The winner is Player $WINNER"