"### Lab 8: Ansible Playbooks for Web Server Configuration

#### Objective
Automate the installation and configuration of a web server using Ansible.

---

### Prerequisites
1. Ensure Ansible is installed on the control node:
   ```bash
   sudo apt install ansible -y  # For Ubuntu/Debian
   sudo yum install ansible -y  # For CentOS/RHEL
   ```

2. Verify SSH access to managed hosts:
   ```bash
   ansible all -i inventory -m ping
   ```

---

### Steps

1. Place the provided files in the same directory:
   - `ansible.cfg`: Configures Ansible settings.
   - `inventory`: Defines the managed hosts.
   - `playbook.yml`: Ansible playbook to configure the web server.

2. Run the playbook:
   ```bash
   ansible-playbook playbook.yml
   ```

---

### Verification
1. Verify that Nginx is installed and running:
   ```bash
   ansible webservers -i inventory -m command -a "systemctl status nginx"
   ```

2. Open a web browser and navigate to the IP address of the managed host. The page should display:
   ```
   Hello World
   ```

---

### Notes
- The playbook installs Nginx, edits the default HTML file, and ensures the service is running.
- Ensure firewalls on the managed hosts allow HTTP traffic (port 80).


