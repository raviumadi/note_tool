# note_tool_config.sh

# Define paths for the main notes file and segregated notes directory
NOTES_FILE_PATH="${HOME}/Documents/Notes/main/notes.txt"
SEGREGATED_NOTES_DIR="${HOME}/Documents/Notes/sorted"

# Ensure directories exist (in case they're not created yet)
mkdir -p "$HOME/Documents/Notes/main" "$HOME/Documents/Notes/sorted"

# Path to the note_tool.sh script
NOTE_TOOL_PATH="$HOME/.local/bin/note_tool.sh"  # Update this if you store note_tool.sh elsewhere

# Export paths so they can be accessed by note_tool.sh
export NOTES_FILE_PATH
export SEGREGATED_NOTES_DIR

# Aliases for quick commands
alias note="$NOTE_TOOL_PATH add"
alias shownotes="$NOTE_TOOL_PATH view main"
alias shownotes_month="$NOTE_TOOL_PATH view"
alias setnotedir="$NOTE_TOOL_PATH set-dir"
alias segregatenotes="$NOTE_TOOL_PATH segregate"