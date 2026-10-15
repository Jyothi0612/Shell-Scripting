#!/bin/bash

echo "All arguments passed to this script are:: $@"
echo "All arguments passed to this script as a word:: $*"
echo "Total number of arguments passed to this script are:: $#"
echo "First argument passed to this script is:: $1"
echo "Script name is:: $0"
echo "Real Path of the script is:: $(realpath $0)"
echo "Who is executing this script:: $USER"
echo "Current working directory is:: $PWD"
echo "Home directory of the user executing this script is:: $HOME"
echo "Current process ID of this script is:: $$"
sleep 10 &
echo "Process ID of the last command executed in the background is:: $!"
wait $!
echo "line number : $LINENO"
echo "Exit status of the last command executed is:: $?"
echo "Total time executed by the script is:: $SECONDS seconds"