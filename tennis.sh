#!/bin/bash

print_board() {
    # Print the scores
    echo " Player 1: $p1_score         Player 2: $p2_score "

    # Print the board, based on the given score
    echo " --------------------------------- "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "

    case $state in
        3)   
            echo " |       |       #       |       |O"
            ;;
        2)
            echo " |       |       #       |   O   | "
            ;;
        1)
            echo " |       |       #   O   |       | "
            ;;
        0)
            echo " |       |       O       |       | "
            ;;
        -1)
            echo " |       |   O   #       |       | "
            ;;
        -2)
            echo " |   O   |       #       |       | "
            ;;
        -3)
            echo "O|       |       #       |       | "
            ;;
    esac

    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " --------------------------------- "
}

# ------------------------- MAIN -------------------------

# Initialize the game state
p1_score=50 p2_score=50 p1_input=0 p2_input=0 state=0

# Print the initial board
print_board $state $p1_score $p2_score

# Loop until the game is over
while [ $state -gt -3 ] && [ $state -lt 3 ] && [ $p1_score -gt 0 ] && [ $p2_score -gt 0 ]; do
    # Get input and update the score for player 1
    while [ 1 ]; do 
        echo "PLAYER 1 PICK A NUMBER: "
        read -s p1_input

        if ! [[ $p1_input =~ ^[0-9]+$ ]] || [[ $p1_input -gt $p1_score ]]; then
            echo "NOT A VALID MOVE !"
        else
            break
        fi
    done

    p1_score=$(($p1_score - $p1_input))

    # Get input and update the score for player 2
    while [ 1 ]; do 
        echo "PLAYER 2 PICK A NUMBER: "
        read -s p2_input

        if ! [[ $p2_input =~ ^[0-9]+$ ]] || [[ $p2_input -gt $p2_score ]]; then
            echo "NOT A VALID MOVE !"
        else
            break
        fi
    done

    p2_score=$(($p2_score - $p2_input))

    # Update the board state
    if [[ p1_input -gt p2_input ]]; then
        if [[ state -lt 0 ]]; then
            state=1
        else
            state=$(($state + 1))
        fi
    elif [[ p1_input -lt p2_input ]]; then
        if [[ state -gt 0 ]]; then
            state=-1
        else
            state=$(($state - 1))
        fi
    fi

    # Print the board and reveal the inputs
    print_board $state $p1_score $p2_score
    echo -e "       Player 1 played: ${p1_input}\n       Player 2 played: ${p2_input}\n\n"
done

# Print the winner
if [ $state = 3 ]; then
    echo "PLAYER 1 WINS !"
elif [ $state = -3 ]; then
    echo "PLAYER 2 WINS !"
elif [[ $p1_score = 0 ]] && [[ $p2_score != 0 ]]; then
    echo "PLAYER 2 WINS !"
elif [[ $p2_score = 0 ]] && [[ $p1_score != 0 ]]; then
    echo "PLAYER 1 WINS !"
else
    if [ $state -gt 0 ]; then
        echo "PLAYER 1 WINS !"
    elif [ $state -lt 0 ]; then
        echo "PLAYER 2 WINS !"
    else 
        echo "IT'S A DRAW !"
    fi
fi
