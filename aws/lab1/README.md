**Lab 12: AWS Security**

## **Objective**  
The goal of this lab is to:  
1. Set up an AWS account.  
2. Create billing alarms for cost management.  
3. Create two IAM groups:  
   - **Admin**: Full administrative permissions.  
   - **Developer**: Limited access to EC2.  
4. Create IAM users:  
   - `admin-1`: Console access only with MFA enabled.  
   - `admin-2-prog`: CLI access only.  
   - `dev-user`: Both programmatic and console access.  
5. Validate user and group permissions:  
   - List all users and groups via commands.  
   - Test access to EC2 and S3 for each user role.  

---

## **Steps**

### **1. Create Billing Alarms for Cost Management**  
- Set up billing alarms in the AWS Billing Dashboard to monitor costs.  
- Configured an alarm to notify via email when the monthly spending exceeds a defined threshold.

**Screenshot References:**  
- Billing alarm configuration: ![Screenshot 1](./screenshots/Screenshot%202024-12-05%20092142.png)

---

### **2. Set Up IAM Groups**  
- Created two groups:  
   - **Admin** group with `AdministratorAccess` policy.  
   - **Developer** group with `AmazonEC2FullAccess` policy.  
- Added users to respective groups.  

**Screenshot References:**  
- List IAM groups: ![Screenshot 2](./screenshots/Screenshot%202024-12-05%20094523.png)  
- Group creation (Admin): ![Screenshot 3](./screenshots/Screenshot%202024-12-05%20093129.png)  
- Group creation (Developer): ![Screenshot 4](./screenshots/Screenshot%202024-12-05%20093506.png)  

---

### **3. Create IAM Users**  
- **Admin-1 User:**  
   - Console access enabled with a custom password.  
   - Added to the **Admin** group.  
   - Enabled MFA for enhanced security.  

**Screenshot References:**  
- Admin-1 console access setup: ![Screenshot 5](./screenshots/Screenshot%202024-12-05%20093318.png)  
- MFA configuration: ![Screenshot 6](./screenshots/Screenshot%202024-12-05%20092806.png)  

- **Admin-2-prog User:**  
   - CLI access enabled with access keys.  
   - Added to the **Admin** group.  
   - Generated and retrieved access keys.  

**Screenshot References:**  
- CLI user creation for `admin-2-prog`: ![Screenshot 7](./screenshots/Screenshot%202024-12-05%20093519.png)  
- Access key generation: ![Screenshot 8](./screenshots/Screenshot%202024-12-05%20094948.png)  

- **Dev-user:**  
   - Console and programmatic access enabled.  
   - Added to the **Developer** group.  

**Screenshot References:**  
- User setup and group assignment: ![Screenshot 9](./screenshots/Screenshot%202024-12-05%20093912.png)  
- Access key retrieval: ![Screenshot 10](./screenshots/Screenshot%202024-12-05%20094819.png)  

---

### **4. List Users and Groups Using AWS CLI**  
- **Commands:**  
```bash
aws iam list-users
aws iam list-groups
```

**Screenshot References:**  
- **List users and groups**: ![Screenshot 11](./screenshots/Screenshot%202024-12-05%20095123.png)

---

### **5. Validate Permissions**

#### **Admin-1:**
- Logged into the AWS Management Console.  
- Verified access to all services.  

**Screenshot Reference:**  
- Console login: ![Screenshot 12](./screenshots/Screenshot%202024-12-05%20093750.png)

---

#### **Admin-2-prog:**
- Tested CLI access using AWS CLI commands.  

**Commands:**
```bash
aws sts get-caller-identity
aws iam list-users
aws iam list-groups
```

**Screenshot References:**  
- STS and list-users output: ![Screenshot 13](./screenshots/Screenshot%202024-12-05%20095123.png)

---

#### **Dev-user:**
- Verified access to EC2 but restricted access to S3.  

**Screenshot References:**  
- EC2 launch successful: ![Screenshot 14](./screenshots/Screenshot%202024-12-05%20094500.png)  
- S3 bucket creation denied: ![Screenshot 15](./screenshots/Screenshot%202024-12-05%20093856.png)

