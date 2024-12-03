### Lab1: User and Group Management

This guide walks through creating a new group, user, and configuring permissions for installing Nginx with `sudo` without a password.

---

### Objective

- Create a new group named `ivolve`.
- Add a new user to this group.
- Configure the user to:
  - Install Nginx using `sudo` without being prompted for a password.

---

### Steps

#### 1. Create the Group
```bash
sudo groupadd ivolve
```

---

#### 2. Create the User
Create a new user and assign them to the `ivolve` group:
```bash
sudo useradd -m -G ivolve -s /bin/bash ivolveuser
```

Set a secure password for the user:
```bash
sudo passwd ivolveuser
```

---

#### 3. Configure User Permissions
To allow the user to install Nginx without a password:

1. Edit the Sudoers File:
   ```bash
   sudo visudo
   ```

2. Add the following line to the end of the file:
   ```plaintext
   ivolveuser ALL=(ALL) NOPASSWD: /usr/bin/yum install nginx
   ```

---

#### 4. Verify the Configuration
1. Switch to the new user:
   ```bash
   su - ivolveuser
   ```

2. Test installing Nginx:
   ```bash
   sudo yum install nginx
   ```

   - The command should execute without prompting for a password.

