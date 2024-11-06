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
    echo "Usage: note [options]"
    echo
    echo "Options:"
    echo "  -a                Add a new note interactively"
    echo "  -v main           View main notes file"
    echo "  -v YYYY MM        View notes for a specific year and month (e.g., -v 2024 11)"
    echo "  -s                Segregate notes by month and year"
    echo "  -h                Show this help message"
}

# Function to add a new note
add_note() {
    TIMESTAMP=$(date +"%d %B %Y at %H:%M")

    # Prompt for the note if not provided as an argument
    if [ -z "$1" ]; then
        echo "Write your note below and press Enter (leave empty to cancel):"
        read -r NOTE
    else
        NOTE="$1"
    fi

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
    
    awk -v dir="$SEGREGATED_DIR" '
    function get_month_number(month) {
        if (month == "January") return "01"
        else if (month == "February") return "02"
        else if (month == "March") return "03"
        else if (month == "April") return "04"
        else if (month == "May") return "05"
        else if (month == "June") return "06"
        else if (month == "July") return "07"
        else if (month == "August") return "08"
        else if (month == "September") return "09"
        else if (month == "October") return "10"
        else if (month == "November") return "11"
        else if (month == "December") return "12"
        else return "00"
    }

    /^[0-9]{2} [A-Za-z]+ [0-9]{4} at [0-9]{2}:[0-9]{2} -->/ {
        if (note) {
            print note "\n" > output_file
            close(output_file)
        }
        
        split($0, timestamp, " ")
        month = timestamp[2]
        year = timestamp[3]
        month_num = get_month_number(month)
        output_file = dir "/" year "-" month_num "_notes.txt"
        note = $0 "\n"
        next
    }
    
    {
        note = note $0 "\n"
    }
    
    END {
        if (note) {
            print note "\n" >> output_file
            close(output_file)
        }
    }' "$NOTES_FILE"

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


# Parse command-line options
while getopts "av:sh" option; do
    case $option in
        a) add_note ;;
        v)
            shift
            if [ "$1" == "main" ]; then
            view_notes "main"
            else
            view_notes "$1" "$2"
            fi
            ;;
        s) segregate_notes ;;
        h) show_help ;;
        *) echo "Invalid option. Use '-h' for help."; exit 1 ;;
    esac
done

# Show help if no options are provided
if [ $OPTIND -eq 1 ]; then
    show_help
fi