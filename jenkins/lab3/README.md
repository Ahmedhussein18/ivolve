### Lab 24: Jenkins Shared Libraries

#### **Objective**
Implement Jenkins Shared Libraries to reuse code across multiple pipelines for application deployment. This includes:
1. Building and pushing a Docker image from a GitHub repository.
2. Deploying the application to Kubernetes using the shared library.

---

### **Steps**

#### **1. Set Up the Shared Library**
1. **Directory Structure**:
   Create a new Git repository for the shared library with the following structure:
   ```plaintext
   (repository root)
   └── vars/
       ├── BuildAndPush.groovy
       ├── DeployToKubernetes.groovy
   ```

2. **Add Shared Library Logic**:
   - **`vars/BuildAndPush.groovy`**:
     Handles Docker image building and pushing.
   - **`vars/DeployToKubernetes.groovy`**:
     Handles Kubernetes deployment and YAML management.

3. Commit and push the shared library to a Git repository.

---

#### **2. Configure Jenkins to Use the Shared Library**
1. Go to Jenkins → **Manage Jenkins → Configure System**.
2. Under **Global Pipeline Libraries**, click **Add**:
   - **Name**: `FirstShareLibrary` (must match the `@Library` annotation in the `Jenkinsfile`).
   - **Default Version**: `main` (or the default branch of your library repository).
   - **Retrieval Method**: **Modern SCM**.
   - Configure the Git repository URL for the shared library.

---

#### **3. Create and Configure the Pipeline**
1. **Pipeline Configuration**:
   - Add your `Jenkinsfile` (provided above) to the application repository.
   - Ensure the `Jenkinsfile` references the shared library using:
     ```groovy
     @Library('FirstShareLibrary') _
     ```

2. **Add Required Credentials in Jenkins**:
   - **GitHub Credentials**:
     1. Navigate to **Manage Jenkins → Credentials → System → Global credentials**.
     2. Click **Add Credentials** and select:
        - **Kind**: Username with password.
        - **ID**: `github-token`.
   - **Docker Hub Credentials**:
     1. Add Docker Hub credentials with:
        - **Kind**: Username with password.
        - **ID**: `dockerhub-access-token`.
   - **Kubernetes Kubeconfig File**:
     1. Upload the kubeconfig file as a **Secret file**:
        - **Kind**: Secret file.
        - **ID**: `kubeconfig-file-id`.

---

#### **4. Explanation of Jenkinsfile and Shared Library**

1. **Jenkinsfile**:
   - Contains two stages:
     - **Build and Push Docker Image**: Uses the `BuildAndPush` shared library.
     - **Deploy to Kubernetes**: Uses the `DeployToKubernetes` shared library.

2. **BuildAndPush.groovy**:
   - Clones the GitHub repository using credentials.
   - Builds the Docker image and tags it with the specified name and tag.
   - Pushes the image to Docker Hub using Docker Hub credentials.

3. **DeployToKubernetes.groovy**:
   - Ensures the deployment YAML file exists or generates it dynamically.
   - Updates the deployment YAML file with the latest Docker image.
   - Applies the Kubernetes deployment using a kubeconfig file uploaded to Jenkins.

---

### **Verification**
1. Trigger the Jenkins pipeline and ensure the following:
   - Docker image is successfully built and pushed to Docker Hub.
   - Deployment YAML is updated with the new image and applied to the Kubernetes cluster.
2. Check the Kubernetes cluster:
   ```bash
   kubectl get pods
   kubectl get deployments
   ```


