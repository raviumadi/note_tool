# note_tool_config.sh

# Define paths for the main notes file and segregated notes directory
NOTES_FILE_PATH="${HOME}/Documents/Notes/main/notes.txt"
SEGREGATED_NOTES_DIR="${HOME}/Documents/Notes/sorted"

# Ensure directories exist (in case they're not created yet)
mkdir -p "$HOME/Documents/Notes/main" "$HOME/Documents/Notes/sorted" "$HOME/Documents/Notes/.bin"

# Path to the note_tool.sh script
NOTE_TOOL_PATH="$HOME/Documents/Notes/.bin/note_tool.sh"  # Update this if you store note_tool.sh elsewhere

# Export paths so they can be accessed by note_tool.sh
export NOTES_FILE_PATH
export SEGREGATED_NOTES_DIR

# Single alias for using the tool with options
alias note="$NOTE_TOOL_PATH"