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
        log_message "Starting the pipeline..."
        log_message "Step 1: Compiling Java code..."
        
        # Run the Java compiler and send all output/errors to a log file
        javac target_app/Main.java > logs/build.log 2>&1
        
        # Check the exit code of the javac command
        if [ $? -eq 0 ]; then
            log_message "✅ Build Successful!"
        else
            log_message "❌ Build Failed! Check logs/build.log for details."
            exit 1 # Stop the pipeline immediately
        fi
	# --- DAY 4 ADDITION STARTS HERE ---
        log_message "Step 2: Running automated tests..."
        
        # Execute the compiled Java app and pass it some dummy arguments
        # We use >> to APPEND to the log file instead of overwriting it
        java -cp target_app Main "TestCase1" "TestCase2" >> logs/build.log 2>&1
        
        if [ $? -eq 0 ]; then
            log_message "✅ All Tests Passed (Execution Successful)!"
        else
            log_message "❌ Tests Failed! App crashed during runtime. Check logs/build.log."
            exit 1
        fi
        # --- DAY 4 ADDITION ENDS HERE ---
        ;;
    *)
        log_message "Error: Unknown command '$1'"
        show_help
        exit 1
        ;;
esac

