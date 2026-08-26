#!/bin/bash

# Function to print formatted logs
log_message() {
    # $1 inside a function means the first argument passed TO THE FUNCTION
    echo "[SentinelCI] $1"
}

# Function to send Discord notifications
send_notification() {
    local message=$1
    local webhook_url="https://discord.com/api/webhooks/1542102780385173574/mfWdp_uVoIfLJtNKl8tQ716nFpE2DV58NtVuPvLjBouEpZo6L3s9YmX4WvFWzn-9Hsfj"
    
    # Build the JSON payload
    local json_payload="{\"content\": \"$message\"}"
    
    # Use curl to send a POST request to Discord silently (-s)
    curl -s -H "Content-Type: application/json" -d "$json_payload" "$webhook_url" > /dev/null
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
        
        # Compile the code
        javac target_app/Main.java > logs/build.log 2>&1
        
        # Check if the build passed or failed
        if [ $? -eq 0 ]; then
            log_message "✅ Build Successful!"
        else
            log_message "❌ Build Failed! Check logs/build.log for details."
            send_notification "🚨 **SentinelCI Alert:** Build Failed! Check logs for syntax errors."
            exit 1 # Stop the pipeline
        fi

        log_message "Step 2: Running automated tests..."
        
        # Run the compiled code
        java -cp target_app Main "TestCase1" "TestCase2" >> logs/build.log 2>&1
        
        # Check if the tests passed or crashed
        if [ $? -eq 0 ]; then
            log_message "✅ All Tests Passed (Execution Successful)!"
            send_notification "✅ **SentinelCI Success:** Build and tests passed perfectly! Ready for deployment."
        else
            log_message "❌ Tests Failed! App crashed during runtime. Check logs/build.log."
            send_notification "🚨 **SentinelCI Alert:** Tests Failed during runtime! App crashed."
            exit 1 # Stop the pipeline
        fi
        ;;
        # --- DAY 4 ADDITION ENDS HERE ---
    *)
        log_message "Error: Unknown command '$1'"
        show_help
        exit 1
        ;;
esac

