### Lab 17: Multi-Tier Application Deployment with Terraform

#### Objective
Deploy a multi-tier application architecture on AWS using Terraform. The architecture includes:
- A manually created VPC (`ivolve`) retrieved using the Terraform `data` block.
- Two subnets (public and private).
- An EC2 instance for the application tier.
- An RDS database for the data tier.
- A local provisioner to write the EC2 instance IP address to a file called `ec2-ip.txt`.

---

### Prerequisites

1. **AWS Account**: Ensure you have an active AWS account.
2. **Terraform Installed**: Install Terraform on your local machine:
   ```bash
   terraform --version
   ```

3. **AWS CLI Configured**: Configure AWS credentials:
   ```bash
   aws configure
   ```

4. **Manually Created VPC**:
   - Create a VPC named `ivolve` in AWS.
   - Note the VPC ID.

---

### Steps

#### 1. Clone the Repository
Clone the repository or place the Terraform files in your working directory.

#### 2. Initialize Terraform
Run the following command to initialize Terraform:
```bash
terraform init
```

#### 3. Plan the Deployment
Preview the changes Terraform will make:
```bash
terraform plan
```

#### 4. Apply the Configuration
Deploy the infrastructure:
```bash
terraform apply
```

#### 5. Verify the Deployment
1. Check the AWS Console to ensure the resources (subnets, EC2, RDS) are created.
2. Verify the `ec2-ip.txt` file contains the public IP of the EC2 instance:
   ```bash
   cat ec2-ip.txt
   ```

---

### Terraform Configuration Overview

1. **VPC Data Block**:
   - Use the `data` block to retrieve the VPC ID of the manually created `ivolve` VPC.

2. **Subnets**:
   - Create two subnets:
     - Public Subnet: Hosts the EC2 instance.
     - Private Subnet: Hosts the RDS database.

3. **EC2 Instance**:
   - Deploy an EC2 instance in the public subnet.
   - Use a local provisioner to write the public IP to `ec2-ip.txt`.

4. **RDS Database**:
   - Deploy an RDS database in the private subnet.

---

### Example Commands

- **View Terraform State**:
  ```bash
  terraform show
  ```

- **Destroy the Resources**:
  ```bash
  terraform destroy
  ```

---

### Notes

- **Resource Naming**: Ensure resources are tagged appropriately for identification in the AWS Console.
- **Security**: Apply security groups to allow appropriate traffic (e.g., SSH to EC2, application traffic to RDS).
- **Provisioner**: The local provisioner writes the EC2 instance's public IP to `ec2-ip.txt` for reference.
- **RDS Connectivity**: Use the EC2 instance to connect to the RDS database for security and accessibility.

