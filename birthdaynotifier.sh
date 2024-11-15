#!/bin/bash

today=$(date +%d-%m)

birthday_file="birthdays.txt"

usage() {
    echo "Usage: $0 [-p path_to_birthdays_file]"
    exit 1
}

while getopts "p:" opt; do
    case $opt in
        p)
            birthday_file="$OPTARG"
            ;;
        *)
            usage
            ;;
    esac
done

if [[ ! -f $birthday_file ]]; then
    echo "Birthday file not found!"
    exit 1
fi

birthday_today=false

GREEN='\033[1;32m'
RESET='\033[0m'

while IFS=: read -r name date; do
    # Trim whitespace
    name=$(echo "$name" | xargs)
    date=$(echo "$date" | xargs)

    if [[ "$date" == "$today" ]]; then
        echo -e "Happy Birthday, ${GREEN}$name${RESET}!"
        birthday_today=true
    fi
done < "$birthday_file"

if ! $birthday_today; then
    echo "No birthdays today."
fi
