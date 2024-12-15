### Lab 21: Terraform Workspace
![Terraform architecture]("Screenshot 2024-12-11 100126.png")
#### Objective
1. Create a Terraform workspace named `ivolve`.
2. Implement a highly available architecture as shown in the diagram using modules.
3. Use modules to deploy:
   - Public Load Balancer (LB).
   - Proxy instances in public subnets.
   - Apache instances in private subnets.
4. Output the public Load Balancer IP.
5. Screenshot the public LB output when accessed via a browser.

---

### Prerequisites

1. AWS CLI and Terraform installed:
   ```bash
   terraform --version
   aws --version
   ```

2. AWS credentials configured:
   ```bash
   aws configure
   ```

3. Familiarity with Terraform modules and workspaces.

---

### Steps

#### 1. Create a New Workspace
1. Create a workspace named `ivolve`:
   ```bash
   terraform workspace new ivolve
   ```

2. Verify the active workspace:
   ```bash
   terraform workspace show
   ```

---

#### 2. Implement the Architecture Using Modules
1. **Modules**:
   - Create a module for each of the following:
     - **VPC**: Define the VPC and subnets (public and private).
     - **EC2 Instances**: Deploy proxy (public) and Apache (private) instances.
     - **Load Balancer**: Configure a public-facing Load Balancer.
   
2. Use variables for:
   - AMI IDs.
   - Instance types.
   - Subnet configurations.


#### 3. Output Public LB IP
1. Add an output block in `outputs.tf`:
   ```hcl
   output "load_balancer_ip" {
       value = module.load_balancer.lb_dns_name
   }
   ```

2. After running the configuration, note the Load Balancer's public DNS/IP.

---

### Commands

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Plan and Apply**:
   ```bash
   terraform plan
   terraform apply
   ```

3. **Destroy Resources**:
   ```bash
   terraform destroy
   ```

---

### Notes

1. **Workspaces**:
   - Using a workspace (`ivolve`) keeps the state file separate from other environments.
   
2. **Modules**:
   - Ensure modularized code for reusability.
   - Avoid repeating configurations.

3. **Outputs**:
   - Ensure the public Load Balancer IP/DNS is easily accessible via the outputs.
