function zdev --description "Open a zellij dev layout for a specific directory"
    # Check if argument is provided
    if test (count $argv) -eq 0
        echo "Usage: zdev <dir_name>"
        echo "Example: zdev my_repo"
        return 1
    end

    set target_dir $argv[1]
    
    # Use zoxide to find the directory
    set abs_path (zoxide query $target_dir 2>/dev/null)
    if test $status -ne 0
        echo "Error: Directory '$target_dir' not found in zoxide database"
        return 1
    end

    # Extract directory name for session name
    set session_name (basename $abs_path)
    
    # Change to the target directory
    cd $abs_path
    
    # Check if session already exists (only check running sessions, not exited ones)
    if zellij list-sessions 2>/dev/null | grep -v "\\(EXITED" | grep -q "^$session_name\s"
        echo "Attaching to existing session: $session_name"
        zellij attach $session_name
    else
        echo "Creating new session: $session_name"
        zellij --layout dev-layout attach -c $session_name
    end
end