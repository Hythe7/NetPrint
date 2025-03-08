#!/bin/bash

SERVER_IP="SERVER_IP"  # Type your white server IP here
SAVE_DIR="$HOME/printer/files"
mkdir -p "$SAVE_DIR"

while true; do
    FILES=$(curl -s http://$SERVER_IP:5000/files | jq -r '.[]')
    
    for FILE in $FILES; do
        if [ ! -f "$SAVE_DIR/$FILE" ]; then
            wget http://$SERVER_IP:5000/files/$FILE -O "$SAVE_DIR/$FILE"
            if [ $? -eq 0 ]; then
                echo "Downloaded: $FILE"
                curl -X DELETE http://$SERVER_IP:5000/files/$FILE
                echo "Deleted from server: $FILE"
            fi
        fi
    done
    
    sleep 30  # Check for updates every 15 seconds
done
