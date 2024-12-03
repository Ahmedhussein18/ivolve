### Lab 4: DNS and Network Configuration with Hosts File and BIND9

#### Objective
Demonstrate the differences between using the hosts file and DNS for URL resolution. Modify the hosts file to resolve a URL to a specific IP address, then configure BIND9 as a DNS solution to resolve wildcard subdomains and verify resolution using `dig` or `nslookup` (e.g., `name-ivolve.com`, `192.168.1.10`).

---

### Prerequisites
1. Install **BIND9**:
   ```bash
   sudo yum install bind bind-utils
   ```

2. Ensure the `named` service is installed and available:
   ```bash
   systemctl list-units --type=service | grep named
   ```

---

### Steps

#### Modify the Hosts File

1. Open the `/etc/hosts` file for editing:
   ```bash
   sudo nano /etc/hosts
   ```

2. Add an entry to map the IP address to the hostname:
   ```plaintext
   192.168.1.10 name-ivolve.com
   ```

3. Save and exit the file.

4. Test the resolution using `ping`:
   ```bash
   ping name-ivolve.com
   ```

   You should see responses from the IP address `192.168.1.10`, confirming the hostname is resolved locally using the `/etc/hosts` file.



#### Configure BIND9

1. Create a new zone configuration file `/etc/named.zones`:
   ```plaintext
   zone "name-ivolve.com" {
       type master;
       file "/var/named/db.name-ivolve.com";
   };
   ```

2. Create the zone file `/var/named/db.name-ivolve.com`:
   ```plaintext
   $TTL    86400
   @       IN      SOA     ns.name-ivolve.com. admin.name-ivolve.com. (
                           2024120301 ; Serial
                           3600       ; Refresh
                           1800       ; Retry
                           604800     ; Expire
                           86400 )    ; Minimum TTL

           IN      NS      ns.name-ivolve.com.
   ns      IN      A       192.168.1.10
   @       IN      A       192.168.1.10
   *       IN      A       192.168.1.10
   ```

3. Set permissions for the zone file:
   ```bash
   sudo chown named:named /var/named/db.name-ivolve.com
   sudo chmod 640 /var/named/db.name-ivolve.com
   ```

4. Start the `named` service and enable it on boot:
   ```bash
   sudo systemctl start named
   sudo systemctl enable named
   ```

---

#### 2. Verify DNS Resolution

1. Check the configuration for errors:
   ```bash
   named-checkconf
   named-checkzone name-ivolve.com /var/named/db.name-ivolve.com
   ```

2. Test domain resolution:
   ```bash
   dig name-ivolve.com
   ```

3. Test wildcard subdomains:
   ```bash
   dig sub1.name-ivolve.com
   dig random.name-ivolve.com
   ```

---

### Notes
- The `hosts` file provides local-only name resolution, while BIND9 serves as a scalable DNS solution.

