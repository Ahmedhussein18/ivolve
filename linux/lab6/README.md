### Lab 6: SSH Configurations

#### Objective
Generate public and private keys, enable SSH from your machine to another VM using the key, and configure SSH so you can simply run `ssh ivolve` without specifying the username, IP, or key in the command.

---

### Steps

#### 1. Generate SSH Keys
Generate a public-private key pair on your local machine:
```bash
ssh-keygen -t rsa -b 2048 -f ~/.ssh/ivolve_key
```

---

#### 2. Copy the Public Key to the Target VM
Use the `ssh-copy-id` command to copy your public key to the target VM:
```bash
ssh-copy-id username@<target_vm_ip>
```

- Replace `username` with your username on the target VM.
- Replace `<target_vm_ip>` with the IP address of the target VM.

---

#### 3. Test SSH Access
Verify that you can SSH into the target VM without a password:
```bash
ssh username@<target_vm_ip>
```

---

#### 4. Configure SSH Shortcut
Edit the SSH configuration file on your local machine to set up a shortcut:
```bash
sudo vim ~/.ssh/config
```

Add the following configuration:
```plaintext
Host ivolve
    HostName <target_vm_ip>
    User username
    IdentityFile ~/.ssh/ivolve_key
```

- Replace `<target_vm_ip>` with the IP address of the target VM.
- Replace `username` with your username on the target VM.

Save and exit the file.

---

#### 5. Test the Shortcut
Now, you can SSH into the target VM using the shortcut:
```bash
ssh ivolve
```

This should automatically connect to the desired host.

---

### Notes
- Ensure that the permissions for the keys are secure:
  ```bash
  chmod 600 ~/.ssh/ivolve_key
  chmod 644 ~/.ssh/ivolve_key.pub
  ```


