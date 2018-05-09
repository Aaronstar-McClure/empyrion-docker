#!/bin/bash
sleep 5

cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# start xvfb in the background. this is required for empyrion to start.
# Xvfb :1 -screen 0 800x600x24 &
# Run the Server and patch to background
${MODIFIED_STARTUP} &
echo "waiting for server to start before connecting telnet..."
# Waiting for empyrion server to properly start, connecting too soon will cause failure
sleep 20
# Have netcat connect to internal telnet, check that is is infact internal, and not accessing an outside the docker port
nc localhost 30004
