# Note Tool: Quick and Simple Command-Line Note-Taking

The `note_tool` is a super-easy command-line tool for quick note-taking, organizing, and viewing notes with automatic monthly segregation. It’s designed to be simple and efficient, so you can easily add timestamped notes, view them by date, and organize them in a structured directory.

The Note Tool is a no-frills, command-line solution for those busy workdays when you need to jot down a thought, remember a task, outline your workflow, or capture an idea before it slips away. Perfect for terminal users, it offers a simple and efficient way to take notes without interrupting your flow.

Your notes are all in one file, and with on-demand or automatic monthly segregation (via cron job), you can keep a structured history of your work, like a digital stack of notepaper. Whether it’s to revisit later or track your daily progress, Note Tool keeps your notes accessible and organized.

![Tool Demo](/demo.png)

**The lines are added to the file**
![Output Demo](/demo2.png)

## Table of Contents
- [Note Tool: Quick and Simple Command-Line Note-Taking](#note-tool-quick-and-simple-command-line-note-taking)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
    - [Directory Structure](#directory-structure)
    - [Commands and Usage](#commands-and-usage)
    - [Tool Design and Working](#tool-design-and-working)
    - [Examples](#examples)
    - [Automated Monthly Segregation](#automated-monthly-segregation)
    - [License](#license)
    - [Remarks](#remarks)


## Installation

1. **Clone or Download the Tool**: Download the files `note_tool.sh`, `note_tool_config.sh`, and `setup_note_tool.sh`. Go to the downloaded directory and,


3. **Run the Setup Script**:
   
```bash
chmod +x setup_note_tool.sh
./setup_note_tool.sh
```

This will:
- Create a Notes folder in ~/Documents with main and sorted subdirectories.
- Add a README.txt file in the Notes folder.
- Set up aliases and environment variables in your shell configuration for quick access to the tool.


3.	**Reload the Shell:**
After setup, if the commands don't work right away, either open a new terminal session or run:
```bash
source ~/.bashrc  # or source ~/.zshrc if using Zsh 
```
### Directory Structure

The tool creates a structured Notes folder in your Documents directory:
- ~/Documents/Notes/main: Stores all notes in a single file, notes.txt, in reverse chronological order.
- ~/Documents/Notes/sorted: Holds monthly segregated notes, organized by year and month in separate files (e.g., 2024-11_notes.txt).


### Commands and Usage

Once set up, you can use the following alias commands:

1. **Add a Note**

To add a note quickly, use:
```bash
note
```
and hit `enter`. Then type your note in a single line. Empty line + `enter` does not add anything to the file.

2. **View Notes**

View All Notes in the Main File

To view the main notes file:

```bash
shownotes
```
3. **View Notes for a Specific Month**

To view notes from a specific year and month:

```bash
shownotes_month YYYY MM
```
**Example**
```bash
shownotes_month 2024 11
```
This displays notes from November 2024 in the sorted folder.

3. **Segregate Notes by Month**

To organize the main notes file into monthly files, use
```bash
segregatenotes
```
This command creates monthly files (e.g., 2024-11_notes.txt) in the sorted folder, containing notes only from the specified month.

4. **Set Directories**

If you need to customize the location of the Notes directory, you can edit note_tool_config.sh directly. After making changes, reload the shell configuration:
```bssh
source ~/.bashrc  # or source ~/.zshrc if using Zsh
```
5. **See Commands**
   
```bash
notehelp
```
Shows the available commands and included aliases

### Tool Design and Working

The note_tool is designed with simplicity and modularity in mind. Here’s how it works:

1. **Configuration** (note_tool_config.sh)

	•	Stores paths for NOTES_FILE and SEGREGATED_DIR.
	•	Defines aliases for quick command access (e.g., note, shownotes, segregatenotes).

2. **Main Script** (note_tool.sh)

	•	Provides functions for adding, viewing, and segregating notes:
	•	add_note: Appends a new note with a timestamp to the top of notes.txt.
	•	view_notes: Displays notes from either the main file or a specific month’s file.
	•	segregate_notes: Organizes notes into monthly files based on timestamps.

3. **Setup Script** (setup_note_tool.sh)

	•	Creates the required directory structure and README file.
	•	Sets up configuration by copying note_tool_config.sh and linking it in .bashrc or .zshrc.

### Examples

**Example 1: Adding a Note**
```bash
note + enter
```
    This is a sample note for my project update

_Output: The note is added to notes.txt in the main folder with a timestamp, e.g., 05 November 2024 at 09:45 --> This is a sample note for my project update._

**Example 2: Viewing All Notes**
```bash
shownotes
```
_Output: Displays the entire contents of notes.txt, with the most recent note at the top._

**Example 3: Viewing Notes for a Specific Month**
```bash
shownotes_month 2024 11
```
_Output: Shows notes for November 2024 from the file 2024-11_notes.txt in the sorted folder._

**Example 4: Segregating Notes by Month**
```bash
segregatenotes
```
_Output: Creates files like 2024-11_notes.txt in the sorted folder, organizing notes by month and year._

### Automated Monthly Segregation
To automate monthly segregation, you can set up a cron job. Run crontab -e and add:
```bash
0 0 1 * * ~/.local/bin/note_tool.sh segregate
```

This cron job will run the segregate command at midnight on the first day of each month, ensuring notes are automatically organized by month.

### License
See [License File](/LICENSE.md)

### Remarks

The note_tool provides a convenient, efficient way to manage timestamped notes directly from the command line. With automated monthly organization, you can maintain a clean and organized record of your notes without any extra effort.

Happy note-taking!