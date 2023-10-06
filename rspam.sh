#!/bin/bash
# Commortably access the rspamd web interface
SERVER=imap.ascolab.com
PORT=11334

# create tunnel to RSPAMD in the background
ssh -N -lroot -L$PORT:127.0.0.1:$PORT $SERVER &
SSH_PID=$!

# Wait for a few seconds to ensure the tunnel is established
sleep 2

# open browser
xdg-open http://localhost:$PORT

read -p "Press Enter to close the tunnel..."

# close tunnel
kill $SSH_PID

