# Antivirus Project

## Overview

This project is a simple antivirus program written in Bash. It checks a directory for changes and scans files for suspicious extensions and keywords.

When a file matches one of the rules, the script copies it to a separate directory and removes the original file. The restore script allows the user to review these files and decide whether to restore them or delete them permanently.

## Project Structure

The project contains these files and directories:

- `antivirusd.sh` - Monitors the directory and scans files.
- `restore.sh` - Allows the user to review and restore quarantined files.
- `Makefile` - Provides commands for running the scripts.
- `README.md` - Contains the project documentation.
- `directory-info.last` - Stores the previous directory listing.
- `directory-info.new` - Stores the latest directory listing.
- `test_dir/` - Contains the files being checked.
- `malicious_dir/` - Stores files flagged by the antivirus.

## Requirements

The project requires Ubuntu or another Linux system with Bash and the standard commands used by the scripts.

Make sure both scripts have execute permission:

```bash
chmod +x antivirusd.sh restore.sh
```

## How to Run

### Run the antivirus

Open a terminal in the project directory and run:

```bash
make run
```

The script checks `test_dir` every five seconds. When it detects a change, it scans the files and copies any flagged files to `malicious_dir`.

Press `Ctrl+C` to stop the script.

### Review quarantined files

To open the restore menu, run:

```bash
make restore
```

The script displays the files in `malicious_dir` and asks you to select one by number.

You can choose to:

1. Restore the file to `test_dir`.
2. Permanently delete the file.
3. Leave the file in quarantine.

Enter `0` when asked to select a file if you want to exit.

## Flagged Extensions and Keywords

The flagged extensions are defined in the `Mal_Ext` array in `antivirusd.sh`:

- `exe`
- `bat`
- `vbs`
- `scr`
- `ps1`

The flagged keywords are defined in the `Mal_Words` array in the same file:

- `virus`
- `trojan`
- `malware`
- `worm`
- `ransomware`

A file is flagged if its extension matches one of the listed extensions or its contents contain one of the listed keywords. The keyword search ignores uppercase and lowercase differences.

## How Directory Changes Are Detected

The script saves the current directory listing in `directory-info.last`. It creates a new listing in `directory-info.new` during each check and compares the two files.

If the listings differ, the script scans the directory and updates the previous listing.


