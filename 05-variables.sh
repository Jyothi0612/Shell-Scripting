#!/bin/bash

start_time=$(date +%s)

echo "Script started execution at: $start_time"

sleep 10

end_time=$(date +%s)
echo "Script completed execution at: $end_time"

echo "Total time taken for execution: $((end_time - start_time)) seconds"