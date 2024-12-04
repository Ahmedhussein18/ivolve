### Lab 7: Ansible Installation

#### Objective
Install and configure Ansible Automation Platform on control nodes, create inventories of a managed host, and perform ad-hoc commands to check functionality.

---

### Prerequisites

1. Ensure Python is installed on the control node:
   ```bash
   python3 --version
   ```

2. Update the system package manager:
   ```bash
   sudo apt update  # For Ubuntu/Debian
   ```

3. Install `pip` (Python package manager):
   ```bash
   sudo apt install python3-pip  # For Ubuntu/Debian
   ```

4. Ensure passwordless SSH access is configured between the control node and managed hosts. If not, refer to the SSH configuration lab.

---

### Steps

#### 1. Install Ansible on the Control Node
Install Ansible using the package manager:

For Ubuntu/Debian:
```bash
sudo apt install ansible -y
```

Verify the installation:
```bash
ansible --version
```

---

#### 2. Create an Inventory File
The inventory file lists the managed hosts. Create a file named `inventory`:

```plaintext
[webservers]
192.168.1.20 ansible_user=ubuntu
```

---

#### 3. Create an ansible configuration file
Create ansible.cfg file to set default configurations

```bash
[defaults]
inventory = ./inventory
remote_user = ubuntu
private_key_file = ~/.ssh/id_rsa

[privilege_escalation]
become = True
become_method = sudo
become_user = root
```
---

#### 4. Test Connectivity to Managed Hosts
Use the `ping` module to verify connectivity with the managed hosts:
```bash
ansible all -i inventory -m ping
```

Expected output:
```plaintext
192.168.1.20 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

---

#### 5. Run Ad-Hoc Commands
1. Check disk usage on all managed hosts:
   ```bash
   ansible all -i inventory -m command -a "df -h"
   ```


2. Check uptime of all managed hosts:
   ```bash
   ansible all -i inventory -m command -a "uptime"
   ```

