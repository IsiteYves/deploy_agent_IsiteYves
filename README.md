utomated Project Bootstrapping - Student Attendance Tracker

## Overview
This project automates the setup of a Student Attendance Tracker application using a shell script. It demonstrates Infrastructure as Code (IaC) principles by creating a reproducible, efficient, and reliable development environment.

## Features
- Automated directory structure creation
- Dynamic configuration management using `sed`
- Signal handling with graceful cleanup (SIGINT/Ctrl+C)
- Environment validation (Python3 check)
- Archive creation on interrupt
- Interactive threshold configuration

## Prerequisites
- Bash shell (Linux/macOS) or Git Bash (Windows)
- Python 3.x (recommended for running the application)
- Git

## Installation & Usage

### 1. Clone the Repository
```
git clone https://github.com/IsiteYves/deploy_agent_IsiteYves.git
cd deploy_agent_IsiteYves
```

### 2. Make the Script Executable
```
chmod +x setup_project.sh
```
### 3. Run the Script
```
./setup_project.sh
```
### 4. Follow the Prompts
- Enter a project name (alphanumeric, underscores, hyphens only)
- Choose whether to update attendance thresholds
- If updating, enter new warning and failure percentages (0-100)

## How to Trigger the Archive Feature
The script includes a signal trap that handles user interrupts (SIGINT/Ctrl+C):
1. During execution, press Ctrl+C at any time
2. The script will:
* Create an archive: attendance_tracker_[project_name]_archive.tar.gz
* Delete the incomplete project directory
* Exit gracefully

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
The script uses sed for in-place editing of config.json:
- Default warning threshold: 75%
- Default failure threshold: 50%
- Updates are performed using regex pattern matching

## Running the Application
After setup:

```
cd attendance_tracker_[project_name]
python3 attendance_checker.py
```

## Error Handling
- Validates Python installation
- Ensures project name is not empty
- Validates threshold inputs (numbers 0-100)
- Gracefully handles interrupts

## Notes
- The script is compatible with both Linux and macOS (handles sed differences)
- Archive is created as a .tar.gz file in the current directory
- The incomplete directory is automatically removed after archiving

👨‍💻 Author
Yves Isite

Date
March 2024

## Learning Objectives Achieved
- Shell scripting proficiency
- Directory and file manipulation
- Signal handling and traps
- Stream editing with sed
- Environment validation
- Error handling
- Documentation
- Version control with Git
