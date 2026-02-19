Automated Project Bootstrapping - Student Attendance Tracker

## Introduction
This project uses a shell script to automatically set up a Student Attendance Tracker application. It showcases the concept of Infrastructure as Code (IaC) by providing a reproducible, optimized, and trustworthy development environment.

## Functionality
- Automatic directory creation
- Dynamic configuration management with `sed`
- Signal handling with clean shutdown (SIGINT/Ctrl+C)
- Environment check (Python3 availability)
- Archive creation on signal reception
- Interactive threshold configuration

## Requirements
-  shell environment (Linux/macOS) or Git  (Windows)
- Python 3.x (for running the application)
- Git version control system

## Setup & Usage

### 1. Clone the Repository
```
git clone https://github.com/IsiteYves/deploy_agent_IsiteYves.git
cd deploy_agent_IsiteYves
```

### 2. Give Execution Permissions
```
chmod +x setup_project.sh
```

### 3. Execute the Script
```
./setup_project.sh
```

### 4. Follow the Instructions
- Enter the project name (alphanumeric, underscores, and hyphens only)
- Select whether to update attendance thresholds
- If updating, enter the new warning and failure percentages (0-100)

## How to Use the Archive Functionality
The script contains a signal handling mechanism to catch user interrupts (SIGINT/Ctrl+C):
1. While running, press Ctrl+C at any time
2. The script will:
* Generate an archive: attendance_tracker_[project_name]_archive.tar.gz
* Remove the partially created project directory
* Cleanly shut down

Example:
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

## Generated Project Structure
```
attendance_tracker_[project_name]/
├── attendance_checker.py
├── Helpers/
│   ├── assets.csv
│   └── config.json
└── reports/
    └── reports.log
```

## Configuration Management
The script employs sed for in-place editing of config.json:
- Default warning threshold: 75%
- Default failure threshold: 50%
- Updates are done via regex pattern matching

## Running the Application
After setup:

```
cd attendance_tracker_[project_name]
python3 attendance_checker.py
```

## Error Handling
- Checks Python installation
- Checks if project name is empty
- Checks if threshold values are numbers between 0-100
- Handles interrupts gracefully

## Notes
- The script is compatible with both Linux and macOS (sed compatibility handled)
- Archive is created as a .tar.gz file in the current directory
- The incomplete directory is automatically removed after archiving

👨‍💻 Author
Yves Isite

Date
March 2024

## Learning Objectives Achieved
- Shell scripting mastery
- Directory and file operations
- Signal handling and trapping
- Stream editing with sed
- Environment checks
- Error handling
- Documentation
- Version control with Git
