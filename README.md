Automated Student Attendance Tracker

## Introduction
In this project, I use a shell script to automatically set up a Student Attendance Tracker application.

**Explanatory video:** https://www.loom.com/share/eec0a91a39a846d78eee582e196fd239

## Functionalities
- Automatic directory creation
- Dynamic configuration management with `sed`
- Signal handling with clean shutdown (SIGINT/Ctrl + C)
- I do environment check (Python3 installation)
- Archive creation on signal reception
- We have interactive threshold configuration

## Requirements to run the script
- shell environment (Linux/macOS) or simply Git (Windows)
- Python 3.x (for running the application)
- Git must be installed

## Setup & Usage

### 1. Clone the Repository
```
git clone https://github.com/IsiteYves/deploy_agent_IsiteYves.git
cd deploy_agent_IsiteYves
```

### 2. Give it execution permissions
```
chmod +x setup_project.sh
```

### 3. Execute the Script
```
./setup_project.sh
```

### 4. Follow these instructions
- Enter the project name (only alphanumeric characters, underscores, and hyphens are allowed in that name)
- Select whether to update attendance thresholds or not
- If you choose to update, enter the new warning and failure percentages (0 to 100)

## How to use the archive functionality
The script contains a signal handling mechanism to catch user interrupts (SIGINT/Ctrl + C):
1. While running this script, press Ctrl+C at any time
2. The script will:
* First generate an archive: attendance_tracker_[project_name]_archive.tar.gz
* Then remove the partially created project directory
* Finally cleanly shut down

Example from what I ran:
```
$ ./setup_project.sh
==========================================
  Student Attendance Tracker Setup
==========================================

[*] Project Initialization
Enter project name (used for directory): test_project
^C
[!] SIGINT received: Cleaning up...
[*] Creating archive: attendance_tracker_test_project_archive.tar.gz
[*] Removing incomplete directory...
[✓] Archive created: attendance_tracker_test_project_archive.tar.gz
[✓] Incomplete directory cleaned up
[!] Exiting gracefully...
```

## Generated project structure
```
attendance_tracker_[project_name]/
├── attendance_checker.py
├── Helpers/
│   ├── assets.csv
│   └── config.json
└── reports/
    └── reports.log
```

## Configuration management
The script uses sed for in-place editing of config.json:
- Default warning threshold: 75%
- Default failure threshold: 50%
- Updates are done via a regex pattern matching

## Running the application
After setup, do this:
```
cd attendance_tracker_[project_name]
python3 attendance_checker.py
```

## Error Handling
- This app checks python installation
- It checks if project name is empty
- It checks if threshold values are numbers between 0-100
- It even handles interrupts properly so the app doesn't crash

## Notes
- The script will work with both Linux and macOS (because I handled sed compatibility)
- Archive is created as a .tar.gz file in the current directory
- The incomplete directory is automatically removed after archiving

👨‍💻 Author
Yves Isite

Date
March 2024
