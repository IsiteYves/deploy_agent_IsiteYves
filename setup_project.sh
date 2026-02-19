#!/bin/bash

# setup_project.sh - Automated Project Bootstrapping for Student Attendance Tracker
# Author: Your Name
# Date: $(date +%Y-%m-%d)

# Color codes for better output readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Global variables
PROJECT_NAME=""
ARCHIVE_NAME=""

# Function to handle cleanup on interrupt
cleanup_on_interrupt() {
	echo -e "\n${YELLOW}[!] SIGINT received: Cleaning up...${NC}"

		# Create archive of current state
		if [ -d "attendance_tracker_${PROJECT_NAME}" ]; then
			ARCHIVE_NAME="attendance_tracker_${PROJECT_NAME}_archive"
			echo -e "${BLUE}[*] Creating archive: ${ARCHIVE_NAME}.tar.gz${NC}"
			tar -czf "${ARCHIVE_NAME}.tar.gz" "attendance_tracker_${PROJECT_NAME}"

							    # Delete the incomplete directory
							    echo -e "${BLUE}[*] Removing incomplete directory...${NC}"
							    rm -rf "attendance_tracker_${PROJECT_NAME}"

							    echo -e "${GREEN}[✓] Archive created: ${ARCHIVE_NAME}.tar.gz${NC}"
							    echo -e "${GREEN}[✓] Incomplete directory cleaned up${NC}"
		fi

		echo -e "${YELLOW}[!] Exiting gracefully...${NC}"
		exit 1
	}

											# Set up signal trap
											trap cleanup_on_interrupt SIGINT SIGTERM

											# Function to print banner
											print_banner() {
												echo "=========================================="
												echo "  Student Attendance Tracker Setup"
												echo "=========================================="
											}

											    # Function to validate environment
											    validate_environment() {
												    echo -e "\n${BLUE}[*] Performing environment health check...${NC}"

													    # Check Python installation
													    if command -v python3 &> /dev/null; then
														    PYTHON_VERSION=$(python3 --version 2>&1)
														    echo -e "${GREEN}[✓] Python3 is installed: ${PYTHON_VERSION}${NC}"
													    else
														    echo -e "${RED}[✗] WARNING: Python3 is not installed!${NC}"
														    echo -e "${YELLOW}    Please install Python3 to run the application.${NC}"
													    fi

													    echo -e "${GREEN}[✓] Environment validation complete${NC}"
												    }

																			    # Function to create directory structure
																			    create_directory_structure() {
																				    echo -e "\n${BLUE}[*] Creating project directory structure...${NC}"

																					    # Create main directory
																					    MAIN_DIR="attendance_tracker_${PROJECT_NAME}"
																					    mkdir -p "${MAIN_DIR}"
																					    echo -e "${GREEN}[✓] Created main directory: ${MAIN_DIR}${NC}"

																							    # Create subdirectories
																							    mkdir -p "${MAIN_DIR}/Helpers"
																							    mkdir -p "${MAIN_DIR}/reports"
																							    echo -e "${GREEN}[✓] Created Helpers/ directory${NC}"
																							    echo -e "${GREEN}[✓] Created reports/ directory${NC}"
																						    }

																							    # Function to create source files
																							    create_source_files() {
																								    echo -e "\n${BLUE}[*] Creating application files...${NC}"

																								    MAIN_DIR="attendance_tracker_${PROJECT_NAME}"

																										# Create attendance_checker.py
																										cat > "${MAIN_DIR}/attendance_checker.py" << 'EOF'
																										    #!/usr/bin/env python3
																										    """
																										    Student Attendance Tracker
																										    This script tracks student attendance and generates reports
																										    """

																										    import csv
																										    import json
																										    import os
																										    from datetime import datetime

																										    def load_config():
																											"""Load configuration from config.json"""
																											    config_path = os.path.join('Helpers', 'config.json')
																												try:
																													with open(config_path, 'r') as f:
																														    return json.load(f)
																															except FileNotFoundError:
																																print("Error: config.json not found!")
																																	return None

																																	def load_assets():
																																	    """Load student data from assets.csv"""
																																		assets_path = os.path.join('Helpers', 'assets.csv')
																																		    students = []
																																			try:
																																				with open(assets_path, 'r') as f:
																																					    reader = csv.DictReader(f)
																																							for row in reader:
																																										students.append(row)
																																											return students
																																											    except FileNotFoundError:
																																												    print("Error: assets.csv not found!")
																																													    return []

																																													    def calculate_attendance(attended, total):
																																														"""Calculate attendance percentage"""
																																														    if total == 0:
																																																    return 0
																																																	return (attended / total) * 100

																																																	def main():
																																																	    print("=" * 50)
																																																		print("Student Attendance Tracker")
																																																		    print("=" * 50)

																																																			# Load configuration
																																																			    config = load_config()
																																																				if not config:
																																																						return

																																																						    print(f"\nAttendance Thresholds:")
																																																							print(f"Warning: {config['thresholds']['warning']}%")
																																																							    print(f"Failure: {config['thresholds']['failure']}%")

																																																								# Load student data
																																																								    students = load_assets()
																																																									if not students:
																																																											return

																																																											    print(f"\nLoaded {len(students)} students")

																																																												# Calculate attendance for each student
																																																												    report_data = []
																																																													for student in students:
																																																															attended = int(student.get('classes_attended', 0))
																																																																total = int(student.get('total_classes', 30))  # Default total classes
																																																																	percentage = calculate_attendance(attended, total)

																																																																		status = "Good"
																																																																			if percentage < config['thresholds']['failure']:
																																																																					    status = "FAIL"
																																																																				    elif percentage < config['thresholds']['warning']:
																																																																									status = "WARNING"

																																																																										report_data.append({
																																																																											    'student_id': student['student_id'],
																																																																													'name': student['name'],
																																																																														    'attendance': f"{percentage:.1f}%",
																																																																																'status': status
																																																																															})

																																																																																    # Generate report
																																																																																	print("\nAttendance Report:")
																																																																																	    print("-" * 50)
																																																																																		for student in report_data:
																																																																																				print(f"{student['student_id']}: {student['name']} - {student['attendance']} [{student['status']}]")

																																																																																				    # Save report
																																																																																					timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
																																																																																					    report_path = os.path.join('reports', f'report_{timestamp}.log')

																																																																																						with open(report_path, 'w') as f:
																																																																																							f.write("Attendance Report\n")
																																																																																								f.write("=" * 50 + "\n")
																																																																																									f.write(f"Generated: {datetime.now()}\n\n")
																																																																																										for student in report_data:
																																																																																												    f.write(f"{student['student_id']}: {student['name']} - {student['attendance']} [{student['status']}]\n")

																																																																																													print(f"\nReport saved to: {report_path}")

																																																																																													if __name__ == "__main__":
																																																																																														    main()
																																																																																														    EOF
																																																																																															chmod +x "${MAIN_DIR}/attendance_checker.py"
																																																																																															    echo -e "${GREEN}[✓] Created attendance_checker.py${NC}"

																																																																																																# Create assets.csv
																																																																																																    cat > "${MAIN_DIR}/Helpers/assets.csv" << 'EOF'
																																																																																																    student_id,name,classes_attended,total_classes
																																																																																																    S001,Alice Johnson,25,30
																																																																																																    S002,Bob Smith,18,30
																																																																																																    S003,Charlie Brown,12,30
																																																																																																    S004,Diana Prince,28,30
																																																																																																    S005,Edward Norton,8,30
																																																																																																    EOF
																																																																																																	echo -e "${GREEN}[✓] Created assets.csv${NC}"

																																																																																																	    # Create config.json (with default values)
																																																																																																		cat > "${MAIN_DIR}/Helpers/config.json" << 'EOF'
																																																																																																		{
																																																																																																			    "app_name": "Student Attendance Tracker",
																																																																																																				"version": "1.0.0",
																																																																																																				    "thresholds": {
																																																																																																					    "warning": 75,
																																																																																																						    "failure": 50
																																																																																																					    },
																																																																																																						    "settings": {
																																																																																																							    "log_level": "INFO",
																																																																																																								    "max_students": 100
																																																																																																							    }
																																																																																																					    }
																																																																																																						EOF
																																																																																																						    echo -e "${GREEN}[✓] Created config.json${NC}"

																																																																																																							# Create reports.log (empty initial file)
																																																																																																							    touch "${MAIN_DIR}/reports/reports.log"
																																																																																																								echo -e "${GREEN}[✓] Created reports.log${NC}"
																																																																																																							}

																																																																																																						# Function to update thresholds
																																																																																																						update_thresholds() {
																																																																																																							    echo -e "\n${BLUE}[*] Configuring attendance thresholds...${NC}"

																																																																																																								# Show current values from config
																																																																																																								    CONFIG_FILE="attendance_tracker_${PROJECT_NAME}/Helpers/config.json"

																																																																																																									# Extract current values (simple grep/sed approach)
																																																																																																									    CURRENT_WARNING=$(grep -o '"warning": [0-9]*' "$CONFIG_FILE" | grep -o '[0-9]*')
																																																																																																										CURRENT_FAILURE=$(grep -o '"failure": [0-9]*' "$CONFIG_FILE" | grep -o '[0-9]*')

																																																																																																										    echo -e "Current thresholds - Warning: ${YELLOW}${CURRENT_WARNING}%${NC}, Failure: ${YELLOW}${CURRENT_FAILURE}%${NC}"

																																																																																																											# Ask user if they want to update
																																																																																																											    read -p "Do you want to update attendance thresholds? (y/n): " UPDATE_CHOICE

																																																																																																												if [[ $UPDATE_CHOICE == "y" || $UPDATE_CHOICE == "Y" ]]; then
																																																																																																														# Get new values
																																																																																																															while true; do
																																																																																																																	    read -p "Enter new Warning threshold (default: 75): " NEW_WARNING
																																																																																																																			NEW_WARNING=${NEW_WARNING:-75}
																																																																																																																				    if [[ "$NEW_WARNING" =~ ^[0-9]+$ ]] && [ "$NEW_WARNING" -ge 0 ] && [ "$NEW_WARNING" -le 100 ]; then
																																																																																																																							    break
																																																																																																																						    else
																																																																																																																												echo -e "${RED}Invalid input. Please enter a number between 0 and 100.${NC}"
																																																																																																																				    fi
																																																																																																																			    done

																																																																																																																															    while true; do
																																																																																																																																		read -p "Enter new Failure threshold (default: 50): " NEW_FAILURE
																																																																																																																																			    NEW_FAILURE=${NEW_FAILURE:-50}
																																																																																																																																					if [[ "$NEW_FAILURE" =~ ^[0-9]+$ ]] && [ "$NEW_FAILURE" -ge 0 ] && [ "$NEW_FAILURE" -le 100 ]; then
																																																																																																																																								break
																																																																																																																																							else
																																																																																																																																												    echo -e "${RED}Invalid input. Please enter a number between 0 and 100.${NC}"
																																																																																																																																					fi
																																																																																																																																				done

																																																																																																																																																# Update config.json using sed
																																																																																																																																																	echo -e "${BLUE}[*] Updating configuration with sed...${NC}"

																																																																																																																																																		# For macOS (BSD sed) and Linux (GNU sed) compatibility
																																																																																																																																																			if [[ "$OSTYPE" == "darwin"* ]]; then
																																																																																																																																																					    # macOS
																																																																																																																																																							sed -i '' "s/\"warning\": [0-9]*/\"warning\": $NEW_WARNING/" "$CONFIG_FILE"
																																																																																																																																																								    sed -i '' "s/\"failure\": [0-9]*/\"failure\": $NEW_FAILURE/" "$CONFIG_FILE"
																																																																																																																																																							    else
																																																																																																																																																												# Linux
																																																																																																																																																													    sed -i "s/\"warning\": [0-9]*/\"warning\": $NEW_WARNING/" "$CONFIG_FILE"
																																																																																																																																																															sed -i "s/\"failure\": [0-9]*/\"failure\": $NEW_FAILURE/" "$CONFIG_FILE"
																																																																																																																																																			fi

																																																																																																																																																																	echo -e "${GREEN}[✓] Thresholds updated successfully!${NC}"
																																																																																																																																																																		echo -e "New values - Warning: ${GREEN}${NEW_WARNING}%${NC}, Failure: ${GREEN}${NEW_FAILURE}%${NC}"
																																																																																																																																																																	else
																																																																																																																																																																				    echo -e "${YELLOW}[!] Keeping default threshold values${NC}"
																																																																																																												fi
																																																																																																											}

																																																																																																																																																																			# Function to display summary
																																																																																																																																																																			display_summary() {
																																																																																																																																																																				    echo -e "\n${GREEN}==========================================${NC}"
																																																																																																																																																																					echo -e "${GREEN}  Setup Complete!${NC}"
																																																																																																																																																																					    echo -e "${GREEN}==========================================${NC}"

																																																																																																																																																																						MAIN_DIR="attendance_tracker_${PROJECT_NAME}"

																																																																																																																																																																						    echo -e "\n${BLUE}Project Structure:${NC}"
																																																																																																																																																																							echo "├── ${MAIN_DIR}/"
																																																																																																																																																																							    echo "│   ├── attendance_checker.py"
																																																																																																																																																																								echo "│   ├── Helpers/"
																																																																																																																																																																								    echo "│   │   ├── assets.csv"
    echo "│   │   └── config.json"
    echo "│   └── reports/"
    echo "│       └── reports.log"

    echo -e "\n${BLUE}Next Steps:${NC}"
    echo "1. Navigate to project directory: cd ${MAIN_DIR}"
    echo "2. Run the application: python3 attendance_checker.py"
    echo "3. To trigger archive feature: Press Ctrl+C during setup"

    echo -e "\n${GREEN}Happy tracking! 🎓${NC}"
}

# Main execution
main() {
    print_banner

    # Get project name from user
    echo -e "\n${BLUE}[*] Project Initialization${NC}"
    read -p "Enter project name (used for directory): " PROJECT_NAME

    # Validate project name (remove spaces, special characters)
    PROJECT_NAME=$(echo "$PROJECT_NAME" | tr -cd '[:alnum:]_-')

    if [ -z "$PROJECT_NAME" ]; then
	echo -e "${RED}[✗] Error: Project name cannot be empty${NC}"
	exit 1
    fi

    echo -e "${GREEN}[✓] Project name set to: ${PROJECT_NAME}${NC}"

    # Validate environment
    validate_environment

    # Create directory structure
    create_directory_structure

    # Create source files
    create_source_files

    # Update thresholds
    update_thresholds

    # Display summary
    display_summary

    echo -e "\n${GREEN}[✓] Project bootstrapping completed successfully!${NC}"
}

# Run main function
main "$@"
