# **Lab 33: Multi-container Applications**

## **Objective**
1. Create a **Deployment** for Jenkins with an **init container** that sleeps for 10 seconds before the Jenkins container starts.
2. Use **readiness** and **liveness probes**.
3. Create a **NodePort Service** to expose Jenkins.
4. Verify the proper execution of the init container and successful initialization of Jenkins.
5. Compare **readiness vs. liveness probes** and **init containers vs. sidecar containers**.

---

## **Steps**

### **1. Create the Deployment**
1. Use the following YAML file for the Deployment with an init container:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      initContainers:
      - name: init-container
        image: busybox
        command:
        - sh
        - -c
        - sleep 10
      containers:
      - name: jenkins
        image: jenkins/jenkins:lts
        ports:
        - containerPort: 8080
        readinessProbe:
          httpGet:
            path: /login
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: /login
            port: 8080
          initialDelaySeconds: 15
   ```

2. Apply the Deployment:
   ```
   kubectl apply -f jenkins-deployment.yaml
   ```

3. Verify the Deployment and Pods:
   ```
   kubectl get pods
   kubectl describe pod <jenkins-pod-name>
   ```

---

### **2. Create a NodePort Service**
1. Use the following YAML to expose Jenkins via a NodePort Service:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: jenkins-service
   spec:
     type: NodePort
     selector:
       app: jenkins
     ports:
     - protocol: TCP
       port: 8080
       targetPort: 8080
       nodePort: 30080
   ```

2. Apply the Service:
   ```
   kubectl apply -f jenkins-service.yaml
   ```

3. Verify the Service:
   ```
   kubectl get svc jenkins-service
   ```

4. Access Jenkins using the NodePort:
   ```
   http://<node-ip>:30080
   ```

---

### **3. Verify the Init Container and Probes**
1. Verify that the init container runs successfully before the Jenkins container starts:
   ```
   kubectl logs <jenkins-pod-name> -c init-container
   ```

2. Verify the readiness and liveness probes:
   ```
   kubectl describe pod <jenkins-pod-name>
   ```

---

## **Comparison**

### **1. Readiness vs. Liveness Probes**

| **Aspect**           | **Readiness Probe**                                              | **Liveness Probe**                                              |
|----------------------|------------------------------------------------------------------|-----------------------------------------------------------------|
| **Purpose**          | Checks if the container is ready to serve traffic.               | Checks if the container is still alive and functioning.         |
| **Impact**           | If it fails, the pod is removed from the Service endpoints.      | If it fails, Kubernetes restarts the container.                 |
| **Example Use Case** | Waiting for application initialization (e.g., loading configs).  | Detecting application crashes or hangs.                         |

---

### **2. Init Container vs. Sidecar Container**

| **Aspect**           | **Init Container**                                              | **Sidecar Container**                                             |
|----------------------|-----------------------------------------------------------------|-------------------------------------------------------------------|
| **Purpose**          | Runs once before the main container starts.                     | Runs alongside the main container, sharing the pod's lifecycle.   |
| **Execution Order**  | Executes sequentially before the main container.                | Executes concurrently with the main container.                    |
| **Example Use Case** | Preparing configurations or ensuring dependencies are met.      | Logging, monitoring, or proxying traffic for the main container.  |
