### Lab 23: Jenkins Pipeline for Application Deployment

#### **Objective**
Create a Jenkins pipeline that automates the following processes:
1. Build a Docker image from a Dockerfile in GitHub.
2. Push the image to Docker Hub.
3. Update the image in `deployment.yaml`.
4. Deploy the application to a Kubernetes cluster.
5. Add a post-action step in the pipeline.

The `Jenkinsfile` is included in this repository for implementation.

---

### **Prerequisites**

#### **1. Add GitHub Credentials to Jenkins**
1. Open the Jenkins dashboard and navigate to:
   **Manage Jenkins → Credentials → System → Global credentials**.
2. Click **Add Credentials** and select the following:
   - **Kind**: Username with password.
   - **Username**: Your GitHub username.
   - **Password**: Your GitHub personal access token (PAT).
   - **ID**: Provide a recognizable ID (e.g., `github-credentials`).
3. Click **Save**.

#### **2. Add Docker Hub Credentials to Jenkins**
1. Navigate to:
   **Manage Jenkins → Credentials → System → Global credentials**.
2. Click **Add Credentials** and select the following:
   - **Kind**: Username with password.
   - **Username**: Your Docker Hub username.
   - **Password**: Your Docker Hub password or access token.
   - **ID**: Provide a recognizable ID (e.g., `dockerhub-credentials`).
3. Click **Save**.

---

#### **3. Authorize Jenkins to Execute `kubectl` Commands**
1. Create a ServiceAccount for Jenkins in Kubernetes:
   ```bash
   kubectl create serviceaccount jenkins
   ```

2. Bind the ServiceAccount to the `admin` ClusterRole:
   ```bash
   kubectl create clusterrolebinding jenkins-admin --clusterrole=admin --serviceaccount=default:jenkins
   ```

3. Generate a token for the `jenkins` ServiceAccount:
   ```bash
   kubectl create token jenkins
   ```
   - **Copy the token** from the output and save it securely.

4. Retrieve other necessary kubeconfig details:
   - API server URL:
     ```bash
     kubectl cluster-info
     ```

5. Create a kubeconfig file with the retrieved details:
   ```yaml
   apiVersion: v1
   kind: Config
   clusters:
   - cluster:
       certificate-authority: <PATH_TO_CERTIFICATE>
       server: <API_SERVER_URL>
     name: kubernetes
   contexts:
   - context:
       cluster: kubernetes
       user: jenkins
     name: jenkins-context
   current-context: jenkins-context
   users:
   - name: jenkins
     user:
       token: <SERVICE_ACCOUNT_TOKEN>
   ```
   - Replace `<PATH_TO_CERTIFICATE>`, `<API_SERVER_URL>`, and `<SERVICE_ACCOUNT_TOKEN>` with the values obtained earlier.

6. Upload the kubeconfig file to Jenkins:
   - Go to:
     **Manage Jenkins → Credentials → System → Global credentials**.
   - Click **Add Credentials** and select:
     - **Kind**: Secret file.
     - **File**: Upload the kubeconfig file.
     - **ID**: Provide a recognizable ID (e.g., `kubeconfig-credentials`).
   - Click **Save**.

7. Use the kubeconfig secret file in your Jenkins pipeline by referencing its ID when executing `kubectl` commands.

---

### **Verification**
1. Test Docker Hub credentials by running a pipeline stage to log in to Docker Hub.
2. Test GitHub credentials by cloning a repository from the pipeline.
3. Verify Kubernetes access by running `kubectl get nodes` in a Jenkins pipeline stage.
