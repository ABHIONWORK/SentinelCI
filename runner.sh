#!/bin/bash

# Function to print formatted logs
log_message() {
    # $1 inside a function means the first argument passed TO THE FUNCTION
    echo "[SentinelCI] $1"
}
show_help() {
    echo "Usage: ./runner.sh [OPTIONS]"
    echo "Options:"
    echo "  --help    Show this help message"
    echo "  --run     Start the CI/CD pipeline pipeline"
}
# Check if the user didn't pass any arguments
if [ -z "$1" ]; then
    log_message "Error: No arguments provided."
    show_help
    exit 1
fi

# The Case Statement (like a Java switch statement)
case "$1" in
    --help)
        show_help
        ;;
    --run)
        log_message "Starting the pipeline... (Build steps coming tomorrow!)"
        ;;
    *)
        log_message "Error: Unknown command '$1'"
        show_help
        exit 1
        ;;
esac

