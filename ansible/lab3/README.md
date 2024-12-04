### Lab 9: Ansible Vault

#### Objective
Write an Ansible playbook to install MySQL, create the `ivolve` database, create a user with all privileges on the `ivolve` database, and use Ansible Vault to encrypt sensitive information such as the database user password.

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


---

### Steps

#### 1. Encrypt Sensitive Data with Ansible Vault
1. Create an encrypted file to store sensitive information:
   ```bash
   ansible-vault create mysql_vars
   ```

2. Add the following content to the file:
   ```yaml
   mysql_root_password: root
   mysql_user_password: 123
   ```

3. Save and exit. The file will now be encrypted.

---

#### 2. Write the Ansible Playbook
Save the following playbook as `playbook.yml`:

```yaml
---
- name: MySQL setup with Ansible Vault
  hosts: webserver
  become: yes
  vars_files:
    - mysql_vars

  tasks:
    - name: Install MySQL server
      ansible.builtin.apt:
        name: mysql-server
        state: present
        update_cache: yes

    - name: Start MySQL service
      ansible.builtin.service:
        name: mysql
        state: started
        enabled: true
  
    - name: Install python-mysql
      apt:
        name: python3-pymysql
        state: latest 

   	
    - name: Set root password
      ansible.builtin.shell: 
     	 mysql -u root -p'{{ mysql_root_password }}' -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '{{mysql_root_password}}';" 
   
    - name: Create ivolve database
      ansible.builtin.mysql_db:
        name: ivolve
        state: present
        login_user: root
        login_password: "{{ mysql_root_password }}"

    - name: Create MySQL user with privileges
      ansible.builtin.mysql_user:
        name: ivolveuser
        password: "{{ mysql_user_password }}"
        priv: 'ivolve.*:ALL'
        state: present
        login_user: root
        login_password: "{{ mysql_root_password }}"
```

---

#### 3. Run the Playbook
Run the playbook using the following command:

If you want to provide the vault password interactively:
```bash
ansible-playbook -i inventory playbook.yml --ask-vault-pass
```

If you want to use a vault password file:
1. Create a password file (e.g., `vault_password.txt`) and add the password to it.
2. Run the playbook:
   ```bash
   ansible-playbook -i inventory playbook.yml --vault-password-file vault_password.txt
   ```

---

### Verification

1. Verify that MySQL is installed and running:
   ```bash
   ansible -i inventory -m command -a "systemctl status mysql"
   ```

2. Log into the MySQL server to confirm the database and user creation:
   ```bash
   mysql -u root -p'root'
   SHOW DATABASES;
   SELECT user FROM mysql.user WHERE user = 'ivolveuser';
   ```

---

### Notes

- Use Ansible Vault to securely store sensitive data such as passwords.
- The playbook ensures idempotency: running it multiple times won't recreate existing resources.
- For production, use strong passwords and follow best practices for database security.



