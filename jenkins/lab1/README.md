### Lab 22: Jenkins Installation

#### **Objective**
Install Jenkins on Ubuntu and configure it to run as a service.

---

### **Steps**

#### **1. Update System and Install Java 17**
1. Update system packages:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. Install OpenJDK 17:
   ```bash
   sudo apt install -y openjdk-17-jdk
   ```

3. Verify Java installation:
   ```bash
   java -version
   ```

---

#### **2. Add Jenkins Repository**
1. Add Jenkins GPG key and repository:
   ```bash
   curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
   echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/' | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
   ```

2. Update package lists:
   ```bash
   sudo apt update
   ```

---

#### **3. Install and Configure Jenkins**
1. Install Jenkins:
   ```bash
   sudo apt install -y jenkins
   ```

2. Start and enable Jenkins:
   ```bash
   sudo systemctl start jenkins
   sudo systemctl enable jenkins
   ```

3. Verify Jenkins status:
   ```bash
   sudo systemctl status jenkins
   ```

---

#### **4. Access Jenkins**
1. Open Jenkins in a browser using:
   ```
   http://<server-ip>:8080
   ```

2. Retrieve the initial admin password:
   ```bash
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```

3. Log in with the password and complete the setup wizard.

---

### **Verification**
- Confirm Jenkins is accessible at `http://<server-ip>:8080`.
- Check Jenkins is running as a service:
   ```bash
   sudo systemctl status jenkins
   ```
