### Lab 20: Terraform Variables and Loops
![Terraform architecture]("Screenshot 2024-12-11 095255.png")
#### Objective
1. Deploy a VPC with:
   - 1 public subnet containing an EC2 instance running Nginx.
   - 1 private subnet containing an EC2 instance running Apache.
2. Use variables and loops to avoid code repetition.
3. Use a remote provisioner to configure Nginx and Apache.
4. Import a manually created NAT Gateway into Terraform.
5. Output public and private IPs of EC2 instances.

---

### Prerequisites

1. AWS CLI and Terraform installed.
2. AWS credentials configured:
   ```bash
   aws configure
   ```

3. NAT Gateway created manually in AWS.

---

### Steps

#### 1. Initialize Terraform
Run the following command:
```bash
terraform init
```

---

#### 2. Import the NAT Gateway
Import the manually created NAT Gateway into Terraform:
```bash
terraform import aws_nat_gateway.my_nat_gateway <nat-gateway-id>
```

---

#### 3. Plan and Apply
1. Preview the changes:
   ```bash
   terraform plan
   ```

2. Deploy the infrastructure:
   ```bash
   terraform apply
   ```

---

### Verification

1. **NAT Gateway**:
   - Verify the NAT Gateway is managed by Terraform:
     ```bash
     terraform state show aws_nat_gateway.my_nat_gateway
     ```

2. **EC2 Instances**:
   - Access Nginx (public subnet) and Apache (private subnet) using the public IPs from the output:
     ```
     http://<nginx-public-ip>
     http://<apache-public-ip>
     ```

3. **Outputs**:
   - Public and private IPs of the EC2 instances are displayed as part of the Terraform output.

---

### Notes

- Use loops and variables to ensure modular and reusable configurations.
- Verify security group rules for HTTP (port 80) and SSH (port 22) access.
- Ensure the NAT Gateway is correctly configured to provide outbound access for private subnet instances.

