### Lab 10: Ansible Roles for Application Deployment

#### Objective
Organize Ansible playbooks using roles to install Jenkins, Docker, and OpenShift CLI (`oc`).

---

### Prerequisites

1. Ensure Ansible is installed on the control node:
   ```bash
   sudo apt install ansible -y  # For Ubuntu/Debian
   ```

2. Verify SSH access to managed hosts:
   ```bash
   ansible all -i inventory -m ping
   ```

3. Ensure the managed hosts have access to the required package repositories.

---

### Steps

1. Place the following files in the same directory:
   - `roles/jenkins/tasks/main.yml`: Configures Jenkins installation.
   - `roles/docker/tasks/main.yml`: Configures Docker installation.
   - `roles/oc/tasks/main.yml`: Configures OpenShift CLI installation.
   - `playbook.yml`: The main playbook.
   - `inventory`: Defines the managed hosts.
   - `ansible.cfg`: Defines the default configuration.

2. Run the playbook:
   ```bash
   ansible-playbook -i inventory playbook.yml
   ```

---

### Verification


1. Verify Jenkins installation:
   ```bash
   ansible -i inventory -m command -a "systemctl status jenkins"
   ```

2. Verify Docker installation:
   ```bash
   ansible -i inventory -m command -a "docker --version"
   ```

3. Verify OpenShift CLI installation:
   ```bash
   ansible -i inventory -m command -a "oc version"
  ```

---



