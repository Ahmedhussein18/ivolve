### Lab 18: Terraform Modules

#### Objective
Use Terraform modules to:
1. Create a VPC with two public subnets.
2. Define a reusable EC2 module to deploy an EC2 instance with Nginx installed using user data.
3. Use the EC2 module to deploy one EC2 instance in each public subnet.

---

### Prerequisites

1. **AWS Account**: Ensure you have an active AWS account with credentials configured.
2. **Terraform Installed**: Install Terraform on your local machine:
   ```bash
   terraform --version
   ```

3. **AWS CLI Configured**: Configure AWS credentials:
   ```bash
   aws configure
   ```

---

### Steps

#### 1. Clone the Repository
Clone the repository or ensure your working directory contains the following:
   - `main.tf`: Defines the VPC and subnets.
   - `modules/ec2/`: Contains the EC2 module.
   - `variables.tf`: Declares input variables for the configuration.
   - `outputs.tf`: Defines the output values for resources.

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
1. Check the AWS Console to ensure the resources (VPC, subnets, EC2 instances) are created.
2. Verify that Nginx is installed and running on both EC2 instances:
   - Access the public IP of each EC2 instance in your browser:
     ```
     http://<ec2-public-ip>
     ```
   - You should see the default Nginx welcome page.

---

### Terraform Configuration Overview

1. **VPC and Subnets**:
   - Defined in `main.tf` to create a VPC with two public subnets.

2. **EC2 Module**:
   - Located in `modules/ec2`.
   - Creates an EC2 instance with Nginx installed using the following user data:
     ```bash
     #!/bin/bash
     apt-get update -y
     apt-get install nginx -y
     systemctl start nginx
     ```

3. **Usage of the EC2 Module**:
   - The EC2 module is called twice in `main.tf` to deploy one EC2 instance in each public subnet.

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

- **Module Reusability**: The EC2 module is designed to be reusable for deploying EC2 instances in different subnets or regions.
- **Security Groups**: Ensure the EC2 instances have a security group that allows HTTP (port 80) access for Nginx.
- **Outputs**: Public IPs of the EC2 instances are outputted to the console after deployment for easy access.

---

### Outputs
After running `terraform apply`, the following information will be displayed:
1. Public IPs of both EC2 instances.
2. Subnet IDs of the created public subnets.

---