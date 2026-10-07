#!/bin/bash
# Usage: ./restore.sh dir malicious_dir

DIR="$1"
MAL_DIR="$2"
shopt -s nullglob

while true; do
    files=("$MAL_DIR"/*)

    if [ ${#files[@]} -eq 0 ]; then
        echo "No malicious files to review."
        exit 0
    fi

    echo "Quarantined files:"
    i=1
    for f in "${files[@]}"; do
        echo "  $i) $(basename "$f")"
        i=$((i+1))
    done

    read -p "Pick a file number (0 to quit): " num
    [ "$num" = "0" ] && exit 0

    if ! [[ "$num" =~ ^[0-9]+$ ]] || [ "$num" -lt 1 ] || [ "$num" -gt ${#files[@]} ]; then
        echo "Invalid number."
        continue
    fi

    file="${files[$((num-1))]}"
    name=$(basename "$file")

    echo "1) Restore (false positive)"
    echo "2) Permanently delete"
    echo "3) Leave as is"
    read -p "Choice: " choice

    case "$choice" in
        1) mv "$file" "$DIR/$name"; echo "Restored $name to $DIR." ;;
        2) rm "$file"; echo "$name permanently deleted." ;;
        3) ;;
        *) echo "Invalid choice." ;;
    esac
done
