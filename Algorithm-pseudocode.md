Prepare the Algorithm and Pseudo code for a shell script that will:

1: Create EC2 instances
2: Delete EC2 instances
3: Update Route53 records

1. Create EC2 instances
a.  Get the inputs needed to launch an instance:
      - instance names from the user (mongodb, redis, ...)
      - security group for each name (roboshop-<name>)
      - AMI, instance type, key → same for all
b. Check the user gave at least one instance name
   - if no names → print how to use the script, and stop
     (e.g. "Usage: sh create-ec2.sh <name1> <name2> ...")
c. for each name check if instance already exists
d. Based on the check in c:
   - exists and running  → tell the user "already running"
   - exists and stopped  → start it
   - does not exist      → create it
   - if create/start failed → print an error and stop
e. wait until the instance is running
f. Get the private IP (and the public IP if it's the frontend)
g. what should the user see when the script finishes each instance 

































































?