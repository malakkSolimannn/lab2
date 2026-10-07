# Antivirus Project

## Overview

This project is an antivirus tool that scans files and detects suspicious or flagged files.

## Project Structure
The project contains the following files and directories:

- `Makefile` - Project build configuration.
- `antivirusd.sh` - Antivirus daemon script.
- `directory-info.new` - New directory information.
- `directory-info.last` - Previous directory information.
- `restore.sh` - Script used to restore files.
- `malicious_dir/` - Directory containing flagged/malicious files.
  - `bad.txt`
  - `new.txt`
- `test_dir/` - Directory containing test files.
  - `safe.txt`
- `README.md` - Project documentation.
## Installation
Make sure the required scripts have execute permission:

```bash
chmod +x antivirusd.sh
chmod +x restore.sh
## How to Run

## Flagged Extensions and Keywords

