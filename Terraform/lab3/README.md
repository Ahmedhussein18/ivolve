### Lab 19: Remote Backend and Lifecycle Rules
![Terraform architecture]("Screenshot 2024-12-11 092839.png")
#### Objective
1. Implement a specified architecture diagram using Terraform.
2. Store the Terraform state file in a remote backend (e.g., AWS S3).
3. Use `create_before_destroy` lifecycle rules for EC2 instances and verify the behavior.
4. Compare and document different lifecycle rules.

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

4. **Backend Bucket**: Create an S3 bucket in AWS for storing the Terraform state file.

---

### Steps

#### 1. Clone the Repository
Clone the repository or ensure your working directory contains the following:
   - `main.tf`: Defines the architecture and lifecycle rules.
   - `backend.tf`: Configures the remote backend.
   - `variables.tf`: Declares input variables.
   - `outputs.tf`: Defines the output values for resources.

#### 2. Configure the Remote Backend
1. Edit `backend.tf` to point to your S3 bucket:
   ```hcl
   terraform {
       backend "s3" {
           bucket         = "<your-backend-bucket-name>"
           key            = "terraform/state/lab19.tfstate"
           region         = "<region>"
       }
   }
   ```

2. Initialize Terraform to configure the backend:
   ```bash
   terraform init
   ```

---

#### 3. Implement Lifecycle Rules
1. Add a `lifecycle` block to the EC2 resource in `main.tf`:
   ```hcl
   resource "aws_instance" "example" {
       ami           = var.ami_id
       instance_type = "t2.micro"
       lifecycle {
           create_before_destroy = true
       }
   }
   ```

2. Compare with other lifecycle rules such as `prevent_destroy`:
   - Add `prevent_destroy = true` to test behavior.
   - Example:
     ```hcl
     lifecycle {
         prevent_destroy = true
     }
     ```

---

#### 4. Deploy the Configuration
Run Terraform commands to deploy the architecture:
```bash
terraform plan
terraform apply
```

---

#### 5. Verify Lifecycle Rules
1. **Create Before Destroy**:
   - Modify the EC2 instance (e.g., change the AMI ID) and apply changes.
   - Observe that Terraform creates a new instance before destroying the old one.

2. **Prevent Destroy**:
   - Attempt to destroy the EC2 resource with `prevent_destroy` enabled.
   - Observe that Terraform prevents the destruction.

---

### Terraform Configuration Overview

1. **Remote Backend**:
   - Configured in `backend.tf` to store the state file in an S3 bucket.

2. **Lifecycle Rules**:
   Terraform lifecycle rules allow you to manage how resources are created, updated, and destroyed. Below are the key rules:

   - **`create_before_destroy`**:
     Ensures zero downtime by creating a new resource before destroying the existing one. This is particularly useful for resources like EC2 instances or load balancers where downtime is unacceptable.

   - **`prevent_destroy`**:
     Protects critical resources from accidental deletion. When this rule is enabled, Terraform will block any attempt to destroy the resource and return an error during the `terraform destroy` or `terraform apply` commands.

   - **`ignore_changes`**:
     Ignores specific attributes of a resource during Terraform runs, preventing unintended changes. This is useful when certain properties (e.g., tags or metadata) are updated externally and shouldn't be overwritten by Terraform.
     Example:
     ```hcl
     lifecycle {
         ignore_changes = [
             tags
         ]
     }
     ```

   - **`replace_triggered_by`**:
     Forces resource replacement when a specified dependent resource or attribute changes. This is useful when a resource needs to be recreated due to changes in related resources.
     Example:
     ```hcl
     lifecycle {
         replace_triggered_by = [
             aws_security_group.example.id  # Replace EC2 if the security group changes
         ]
     }
     ```

3. **Example Variables**:
   - AMI ID: Set dynamically for the EC2 instance.
   - Key Pair: Ensure SSH access is configured for verification.

---

### Outputs
After running `terraform apply`, the following information will be displayed:
1. Public IP of the EC2 instance.
2. State file stored in the remote S3 bucket.

---