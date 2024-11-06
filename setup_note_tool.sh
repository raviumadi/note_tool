#!/bin/bash

# Define paths
NOTES_DIRECTORY="$HOME/Documents/Notes"
NOTES_FILE_PATH="$NOTES_DIRECTORY/main/notes.txt"
SEGREGATED_NOTES_DIR="$NOTES_DIRECTORY/sorted"
CONFIG_FILE_PATH="$HOME/path/to/note_tool_config.sh"
TOOL_SCRIPT_PATH="$HOME/path/to/note_tool.sh"

# Ensure main and sorted directories are created
mkdir -p "$NOTES_DIRECTORY/main" "$SEGREGATED_NOTES_DIR"

# Create a README file explaining the directory structure
cat <<EOL > "$NOTES_DIRECTORY/README.txt"
This is the Notes directory created for the note_tool application.

- **main/notes.txt**: Stores all notes in a single main file with timestamps.
- **sorted/**: Contains monthly segregated notes, organized by year and month.

This folder and its contents were generated by note_tool, a command-line tool to help you quickly add, organize, and view notes. You can update the paths for these files in note_tool_config.sh if you wish to change the default locations.

For more information, see the note_tool documentation or use one of the following commands:
- \`note "Your note here"\` to add a new note.
- \`shownotes\` to view the main notes file.
- \`shownotes_month YYYY MM\` to view notes for a specific year and month.
- \`segregatenotes\` to segregate notes by month.

Enjoy using note_tool for streamlined note-taking!
EOL

# Copy note_tool_config.sh and note_tool.sh to their designated locations
cp "$CONFIG_FILE_PATH" "$HOME/.note_tool_config.sh"
cp "$TOOL_SCRIPT_PATH" "$HOME/.local/bin/note_tool.sh"  # Adjust the location if necessary

# Append source command to .bashrc or .zshrc if not already added
if [[ -f "$HOME/.bashrc" ]]; then
    if ! grep -Fxq "source ~/.note_tool_config.sh" "$HOME/.bashrc"; then
        echo "source ~/.note_tool_config.sh" >> "$HOME/.bashrc"
    fi
elif [[ -f "$HOME/.zshrc" ]]; then
    if ! grep -Fxq "source ~/.note_tool_config.sh" "$HOME/.zshrc"; then
        echo "source ~/.note_tool_config.sh" >> "$HOME/.zshrc"
    fi
fi

# Reload the shell configuration
source "$HOME/.bashrc" 2>/dev/null || source "$HOME/.zshrc" 2>/dev/null

# Inform the user that the setup is complete
echo "note_tool has been set up successfully!"
echo "The Notes directory has been created at $NOTES_DIRECTORY."
echo "To start using the tool, open a new terminal session or run 'source ~/.bashrc' or 'source ~/.zshrc'."