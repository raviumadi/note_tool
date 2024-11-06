#!/bin/bash

# Use environment variables if defined, otherwise set default paths
NOTES_FILE="${NOTES_FILE_PATH:-$HOME/Documents/Notes/main/notes.txt}"
SEGREGATED_DIR="${SEGREGATED_NOTES_DIR:-$HOME/Documents/Notes/sorted}"

# Ensure the main notes file exists
touch "$NOTES_FILE"

# Function to display help information
show_help() {
    echo "Note Tool - Command Line Note-Taking Application"
    echo
    echo "Usage:"
    echo "  Main Commands:"
    echo "    $0 add + return                - Add a new note"
    echo "    $0 segregate                   - Segregate notes by month and year"
    echo "    $0 view main                   - View main notes file"
    echo "    $0 view YYYY MM                - View notes for a specific year and month (e.g., $0 view 2024 11)"
    echo "    $0 help                        - Show this help message"
    echo
    echo "  Aliases for Quick Commands:"
    echo "    note + return                  - Quickly add a new note"
    echo "    shownotes                      - Quickly view the main notes file"
    echo "    shownotes_month YYYY MM        - Quickly view notes for a specific year and month"
    echo "    segregatenotes                 - Quickly segregate notes by month and year"
    echo "    notehelp                       - Show this help message with alias information"
}

# Function to add a new note
add_note() {
    TIMESTAMP=$(date +"%d %B %Y at %H:%M")
    NOTE="$1"
    # Prompt for the note
    echo "Write your note below and hit enter (empty is not included):"
    read NOTE

    if [ -n "$NOTE" ]; then
        echo "$TIMESTAMP --> $NOTE" | cat - "$NOTES_FILE" > temp && mv temp "$NOTES_FILE"
        echo "Note added to $NOTES_FILE"
    else
        echo "No note entered. Exiting without saving."
    fi
}

# Function to segregate notes by month and year
segregate_notes() {
    mkdir -p "$SEGREGATED_DIR"

    while IFS= read -r line || [ -n "$line" ]; do
        DATE_PART=$(echo "$line" | grep -oE '^[0-9]+ [A-Za-z]+ [0-9]{4}')
        NOTE_CONTENT=$(echo "$line" | sed 's/^[^>]*--> //')

        if [ -n "$DATE_PART" ]; then
            DAY=$(echo "$DATE_PART" | awk '{print $1}')
            MONTH_NAME=$(echo "$DATE_PART" | awk '{print $2}')
            YEAR=$(echo "$DATE_PART" | awk '{print $3}')

            case "$MONTH_NAME" in
                "January") MONTH_NUM="01" ;;
                "February") MONTH_NUM="02" ;;
                "March") MONTH_NUM="03" ;;
                "April") MONTH_NUM="04" ;;
                "May") MONTH_NUM="05" ;;
                "June") MONTH_NUM="06" ;;
                "July") MONTH_NUM="07" ;;
                "August") MONTH_NUM="08" ;;
                "September") MONTH_NUM="09" ;;
                "October") MONTH_NUM="10" ;;
                "November") MONTH_NUM="11" ;;
                "December") MONTH_NUM="12" ;;
                *) MONTH_NUM="" ;;
            esac

            if [ -n "$MONTH_NUM" ]; then
                OUTPUT_FILE="$SEGREGATED_DIR/${YEAR}-${MONTH_NUM}_notes.txt"
                echo "$line" >> "$OUTPUT_FILE"
            fi
        fi
    done < <(cat "$NOTES_FILE"; echo)
    
    echo "Notes have been segregated by month and saved in $SEGREGATED_DIR."
}

# Function to display notes
view_notes() {
    if [ "$1" == "main" ]; then
        echo "Showing notes from $NOTES_FILE:"
        cat "$NOTES_FILE" | less
    else
        year=$1
        month=$2
        FILE_TO_VIEW="$SEGREGATED_DIR/${year}-${month}_notes.txt"
        if [ -f "$FILE_TO_VIEW" ]; then
            echo "Showing notes from $FILE_TO_VIEW:"
            cat "$FILE_TO_VIEW" | less
        else
            echo "No notes found for ${year}-${month}."
        fi
    fi
}

# Parse command-line arguments
case "$1" in
    "add")
        shift
        add_note "$*"
        ;;
    "segregate")
        segregate_notes
        ;;
    "view")
        shift
        if [ "$1" == "main" ]; then
            view_notes "main"
        else
            view_notes "$1" "$2"
        fi
        ;;
    "help"|"--help"|"-h")
        show_help
        ;;
    *)
        # echo "Invalid command. Use '$0 help' for usage instructions."
        # ;;
esac