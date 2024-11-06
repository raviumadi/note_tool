#!/bin/bash

# Define paths
NOTES_DIRECTORY="$HOME/Documents/Notes"
NOTES_FILE_PATH="$NOTES_DIRECTORY/main/notes.txt"
SEGREGATED_NOTES_DIR="$NOTES_DIRECTORY/sorted"
CONFIG_FILE_PATH="note_tool_config.sh"
TOOL_SCRIPT_PATH="note_tool.sh"

# Ensure main and sorted directories are created
mkdir -p "$NOTES_DIRECTORY/main" "$SEGREGATED_NOTES_DIR" "$NOTES_DIRECTORY/.bin"

# Create a README file explaining the directory structure
cat <<EOL > "$NOTES_DIRECTORY/README.txt"
This is the Notes directory created for the note_tool application.

The note_tool is a super-easy command-line tool for quick note-taking, organizing, and viewing notes with automatic monthly segregation. It’s designed to be simple and efficient, so you can easily add timestamped notes, view them by date, and organize them in a structured directory.

The Note Tool is a no-frills, command-line solution for those busy workdays when you need to jot down a thought, remember a task, outline your workflow, or capture an idea before it slips away. Perfect for terminal users, it offers a simple and efficient way to take notes without interrupting your flow.

Your notes are all in one file, and with on-demand or automatic monthly segregation (via cron job), you can keep a structured history of your work, like a digital stack of notepaper. Whether it’s to revisit later or track your daily progress, Note Tool keeps your notes accessible and organized.

- **main/notes.txt**: Stores all notes in a single main file with timestamps.
- **sorted/**: Contains monthly segregated notes, organized by year and month.

This folder and its contents were generated by note_tool, a command-line tool to help you quickly add, organize, and view notes. You can update the paths for these files in note_tool_config.sh if you wish to change the default locations.

For more information, see the note_tool documentation or use one of the following commands:
- \`note + enter "Your note here"\` to add a new note.
- \`shownotes\` to view the main notes file.
- \`shownotes_month YYYY MM\` to view notes for a specific year and month.
- \`segregatenotes\` to segregate notes by month.
- \'notehelp\' to see the available commands and aliases.
Enjoy using note_tool for streamlined note-taking!
EOL

# Copy note_tool_config.sh and note_tool.sh to their designated locations
cp "$CONFIG_FILE_PATH" "$NOTES_DIRECTORY/.bin/note_tool_config.sh"
cp "$TOOL_SCRIPT_PATH" "$NOTES_DIRECTORY/.bin/note_tool.sh"  # Adjust the location if necessary

# Append source command to .bashrc or .zshrc if not already added
if [[ -f "$HOME/.bashrc" ]]; then
    if ! grep -Fxq "source $NOTES_DIRECTORY/.bin/note_tool_config.sh" "$HOME/.bashrc"; then
        echo "source $NOTES_DIRECTORY/.bin/note_tool_config.sh" >> "$HOME/.bashrc"
    fi
    source ~/.bashrc
    echo "Shell re-sourced"
elif [[ -f "$HOME/.zshrc" ]]; then
    if ! grep -Fxq "source $NOTES_DIRECTORY/.bin/note_tool_config.sh" "$HOME/.zshrc"; then
        echo "source $NOTES_DIRECTORY/.bin/note_tool_config.sh" >> "$HOME/.zshrc"
    fi
    source ~/.zshrc
    echo "Shell re-sourced"
fi

# Reload the shell configuration
source "$HOME/.bashrc" 2>/dev/null || source "$HOME/.zshrc" 2>/dev/null

# Inform the user that the setup is complete
echo "note_tool has been set up successfully!"
echo "The Notes directory has been created at $NOTES_DIRECTORY."
# echo "To start using the tool, open a new terminal session or run 'source ~/.bashrc' or 'source ~/.zshrc'."
echo "
You can now use the following commands:
  - 'note + enter \"Your note here\"': Add a new note
  - 'shownotes'                      : View the main notes file
  - 'shownotes_month YYYY MM'        : View notes for a specific year and month (e.g., shownotes_month 2024 11)
  - 'segregatenotes'                 : Segregate notes by month and year
"