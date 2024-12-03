### Lab 2: Shell Scripting Basics 1

#### Objective
Schedule a script to run daily at 5:00 PM that automates checking disk space usage for the root file system and sends an email alert if usage exceeds a specified threshold (10%).

---

### Prerequisites
1. Ensure a mail service is installed and configured on the system:
   - Install **msmtp**:
     ```bash
     sudo yum install msmtp
     ```

   - Install **ca-certificates** for TLS:
     ```bash
     sudo yum install ca-certificates
     ```

   - Configure msmtp:
     Create the configuration file at `~/.msmtprc` with the following content:
     ```plaintext
     defaults
     auth           on
     tls            on
     tls_trust_file /etc/pki/tls/certs/ca-bundle.crt
     logfile        ~/.msmtp.log

     account        default
     host           smtp.gmail.com
     port           587
     from           your-email@gmail.com
     user           your-email@gmail.com
     password       your-app-password
     ```

     Replace `your-email@gmail.com` and `your-app-password` with your Gmail credentials (App Password).
     Ensure permissions:
     ```bash
     chmod 600 ~/.msmtprc
     ```

   - Test the mail service:
     ```bash
     echo "This is a test email" | msmtp --debug --from=default -t recipient@example.com
     ```

### Steps

#### 1. Create the Script
Write a script to check disk usage and send an email alert.

```bash
#!/bin/bash

// Set the threshold (in percentage)
THRESHOLD=10

// Get the disk usage of the root file system
USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

// Check if usage exceeds the threshold
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo -e \"Subject: Disk Space Alert\\n\\nDisk usage on the root file system is above the threshold. Current usage: ${USAGE}%\" | msmtp --from=default -t recipient@example.com
fi
```

Save the script as `script.sh` and make it executable:

```bash
chmod +x script.sh
```

---

#### 2. Test the Script
Run the script manually to verify:

```bash
./script.sh
```

---

#### 3. Schedule the Script with Cron
To run the script daily at 5:00 PM:

Open the crontab editor:

```bash
crontab -e
```

Add the following line:

```plaintext
0 17 * * * /path/to/script.sh
```



