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
g. Print the instance name and its IP

1. Pseudo code

START

SET ami, instance_type, key
GET NAMES from the user arguments

If no NAMES given
    PRINT "Usage: sh create-ec2.sh <name1> <name2> ..."
    EXIT

FOR each NAME in NAMES
    SET security_group = roboshop-name

    IF instance with NAME exists
        IF state is running
            PRINT "NAME is already running"
        ELSE IF state is stopped
            START the instance
            IF start failed
                PRINT "Error: could not start NAME"
                EXIT
    ELSE
        CREATE instance with NAME, ami, instance_type, key, security_group
        IF create failed
            PRINT "Error: could not create NAME"
            EXIT
    
    WAIT until state is running

    IF NAME is frontend
        GET public IP
    ELSE
        GET private IP

    PRINT "NAME is ready: IP"
END FOR

END



2: Delete EC2 instances

a. Get the instance names from the user (as arguments)
b. Check the user gave at least one name
   - if no names → print how to use the script, and stop
c. Show the names and ask the user to confirm (yes/no)
   - if not "yes" → print "cancelled", and stop
d. For each name, find the instance and its ID
   - not found or already terminated → print "nothing to delete", go to the next name
e. Terminate the instance
   - if terminate failed → print an error and stop
f. Wait until the state is terminated
g. Print "<name> deleted"

Pseudo code
START

GET NAMES from the user arguments

IF no NAMES given
    PRINT "Usage: sh delete-ec2.sh <name1> <name2> ..."
    EXIT

PRINT "These instances will be deleted: NAMES"
READ answer "Are you sure? (yes/no)"
IF answer is not yes
    PRINT "Cancelled"
    EXIT

FOR each NAME in NAMES
    FIND instance with NAME, GET its ID and state

    IF not found OR state is terminated
        PRINT "NAME not found, nothing to delete"
        CONTINUE to next NAME

    TERMINATE instance ID
    IF terminate failed
        PRINT "Error: could not delete NAME"
        EXIT

    WAIT until state is terminated
    PRINT "NAME deleted"
END FOR

END

3. Update Route 53 records

a. Get the inputs:
   - instance names from the user (as arguments)
   - domain name and its hosted zone ID → same for all, set once at the top
   - TTL (short, so changes spread fast) → same for all
b. Check the user gave at least one name
   - if no names → print how to use the script, and stop
c. For each name, find the running instance with that name
   - not found or not running → print an error, go to the next name
d. Get the IP
   - private IP for backend/database servers
   - public IP for the frontend
e. Build the record name: <name>.<domain> (e.g. mongodb.daws92s.store)
f. Check the current record in Route 53
   - already points to the same IP → print "no change needed", go to the next name
   - doesn't exist or has a different IP → create or update it
   - if create/update failed → print an error and stop
g. Print "<record> → <IP>"

Pseudo code
START

SET domain, zone_id, ttl            ← same for all
GET NAMES from the user arguments

IF no NAMES given
    PRINT "Usage: sh update-dns.sh <name1> <name2> ..."
    EXIT

FOR each NAME in NAMES
    FIND running instance with NAME
    IF not found
        PRINT "NAME not running, skipping"
        CONTINUE to next NAME

    IF NAME is frontend 
        GET public IP
    ELSE
        GET private IP

    SET record = NAME.domain

    GET current IP of record from Route 53
    IF current IP is the same as IP
        PRINT "record already correct"
        CONTINUE to next NAME

    CREATE or UPDATE record → IP, with ttl
    IF update failed
        PRINT "Error: could not update record"
        EXIT

    PRINT "record → IP"
END FOR

END