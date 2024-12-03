"### Lab 3: Shell Scripting Basics 2

#### Objective
Create a shell script to ping every server in the `172.16.17.x` subnet (where `x` is a number between 0 and 255). The script should:
- Display the message **“Server 172.16.17.x is up and running”** if the ping succeeds.
- Display the message **“Server 172.16.17.x is unreachable”** if the ping fails.

---

### Prerequisites

1. Check the network interfaces and note the subnet CIDR for the active connection:
   ```bash
   ip addr
   ```
   Look for an interface with the state **UP** and note the subnet in the `inet` field (e.g., `172.16.17.0/24`).

---

### Steps

#### 1. Write the Script
Create a script to ping all IPs in the subnet and display their statuses.

```bash
#!/bin/bash

// Iterate through all possible IP addresses in the 172.16.17.x subnet
for i in {0..255}; do
  // Define the current IP address
  ip="172.16.17.$i"
  
  // Ping the IP address with a timeout of 1 second (adjustable)
  ping -W 1 -c 1 $ip
  
  // Check the exit status of the ping command
  if [ $? -eq 0 ]; then
    echo "Server $ip is up and running"
  else
    echo "Server $ip is unreachable"
  fi
done
```

Save the script as `ping_subnet.sh` and make it executable:
```bash
chmod +x ping_subnet.sh
```

---

#### 2. Test the Script
Run the script manually to verify:
```bash
./ping_subnet.sh
```


