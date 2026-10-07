#!/bin/bash

DIR="$1"
MAL_DIR="$2"
INTERVAL="$3"

Mal_Ext=("exe" "bat" "vbs" "scr" "ps1")
Mal_Words=("virus" "trojan" "malware" "worm" "ransomware")

mkdir -p "$MAL_DIR"

scan() {
    for path in "$DIR"/*; do
        [ -f "$path" ] || continue          
        name=$(basename "$path")
        malicious=false

        if [[ "$name" == *.* ]]; then
            ext="${name##*.}"
            for e in "${Mal_Ext[@]}"; do
                [ "$ext" = "$e" ] && malicious=true
            done
        fi
        
        if [ "$malicious" = false ]; then
            for k in "${Mal_Words[@]}"; do
                if grep -qiaF -- "$k" "$path"; then
                    malicious=true
                    break
                fi
            done
        fi

        if [ "$malicious" = true ]; then
            echo "$name is malicious and it is DELETED"
            if cp "$path" "$MAL_DIR/$name"; then
    		rm "$path"
	    fi
        fi
    done
}

if [ ! -f directory-info.last ]; then
    scan
    ls -l "$DIR" > directory-info.last
fi

while true; do
    sleep "$INTERVAL"
    ls -l "$DIR" > directory-info.new
    if ! diff -q directory-info.last directory-info.new > /dev/null; then
        scan
        cp directory-info.new directory-info.last
    fi
done
