### Lab 15: SDK and CLI Interactions

#### Objective
Use the AWS CLI to create an S3 bucket, configure permissions, upload/download files to/from the bucket, and enable versioning and logging. Ensure permissions are managed using a bucket policy to avoid ACL-related errors.

---

### Prerequisites

1. AWS CLI installed and configured:
   \`\`\`bash
   aws configure
   \`\`\`

2. IAM user with the necessary permissions:
   - `s3:CreateBucket`
   - `s3:PutBucketPolicy`
   - `s3:PutBucketVersioning`
   - `s3:PutBucketLogging`
   - `s3:PutObject`
   - `s3:GetObject`

---

### Steps

#### 1. Create an S3 Bucket
```bash
aws s3api create-bucket --bucket ivolve-marzouk-bucket --region us-east-1
```

---

#### 2. Apply a Bucket Policy
1. Create a file named `policy.json` and write the policy to get and put objects:

2. Apply the policy:
   ```bash
   aws s3api put-bucket-policy --bucket ivolve-marzouk-bucket --policy file://policy.json
   ```

---

#### 3. Enable Versioning
```bash
aws s3api put-bucket-versioning --bucket ivolve-marzouk-bucket --versioning-configuration Status=Enabled
```

---

#### 4. Enable Logging
1. Enable logging for the original bucket:
   ```bash
   aws s3api put-bucket-logging --bucket ivolve-marzouk-bucket --bucket-logging-status '{
       "LoggingEnabled": {
           "TargetBucket": "ivolve-marzouk-bucket",
           "TargetPrefix": "logs/"
       }
   }'
   ```

---

#### 5. Upload and Download Files

**Upload a File:**

Example:
```bash
aws s3 cp policy.json s3://ivolve-marzouk-bucket/policy.json
```

**Download a File:**
```bash
aws s3 cp s3://ivolve-marzouk-bucket/policy.json policy1.json
```

---

#### 6. List Files in the Bucket
```bash
aws s3 ls s3://ivolve-marzouk-bucket
```

---

