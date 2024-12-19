# **Lab 34: Daemonsets & Taint and Toleration**

## **Objective**
1. Understand what a DaemonSet is and its use cases.
2. Create a DaemonSet with an Nginx container.
3. Apply a taint to the Minikube node and observe pod behavior with different tolerations.
4. Compare **Taint & Toleration** and **Node Affinity**.

---

## **1. What is a DaemonSet?**
A **DaemonSet** is a Kubernetes object that ensures a copy of a pod runs on all (or specific) nodes in a cluster.

### **Use Cases**
- Deploying monitoring agents (e.g., Prometheus Node Exporter).
- Running log collection agents (e.g., Fluentd).

---

## **2. Create a DaemonSet**
1. Use the following YAML to create a DaemonSet with an Nginx container:

   ```yaml
   apiVersion: apps/v1
   kind: DaemonSet
   metadata:
     name: nginx-daemonset
   spec:
     selector:
       matchLabels:
         app: nginx
     template:
       metadata:
         labels:
           app: nginx
       spec:
         containers:
         - name: nginx
           image: nginx:latest
           ports:
           - containerPort: 80
   ```

2. Apply the DaemonSet:
   ```
   kubectl apply -f nginx-daemonset.yaml
   ```

3. Verify the DaemonSet and Pods:
   ```
   kubectl get daemonsets
   kubectl get pods -o wide
   ```

---

## **3. Apply a Taint to the Minikube Node**
1. Taint the Minikube node:
   ```bash
   kubectl taint nodes minikube color=red:NoSchedule
   ```

2. Verify the taint:
   ```bash
   kubectl describe node minikube | grep -i taints
   ```

---

## **4. Create Pods with Different Tolerations**

### **Pod with `color=blue` Toleration**
1. Create the following pod YAML:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: pod-blue
   spec:
     tolerations:
     - key: "color"
       operator: "Equal"
       value: "blue"
       effect: "NoSchedule"
     containers:
     - name: nginxkubec 
       image: nginx:latest
   ```

2. Apply the pod:
   ```
   kubectl apply -f pod-blue.yaml
   ```

3. Check the pod status:
   ```bash
   kubectl get pods
   ```
   - The pod will remain in `Pending` state because it does not tolerate the taint `color=red`.

### **Pod with `color=red` Toleration**
1. Modify the YAML to use `color=red`:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: pod-red
   spec:
     tolerations:
     - key: "color"
       operator: "Equal"
       value: "red"
       effect: "NoSchedule"
     containers:
     - name: nginx
       image: nginx:latest
   ```

2. Apply the pod:
   ```
   kubectl apply -f pod-red.yaml
   ```

3. Check the pod status:
   ```bash
   kubectl get pods
   ```
   - The pod will now schedule on the `minikube` node because it tolerates the taint `color=red`.

---

## **5. Comparison Between Taint & Toleration & Node Affinity**

| **Aspect**        | **Taint**                                | **Toleration**                           | **Node Affinity**                                          |
|-------------------|------------------------------------------|------------------------------------------|-----------------------------------------------------------|
| **Purpose**       | Restricts pods from scheduling on nodes. | Allows pods to tolerate taints on nodes. | Ensures pods are scheduled on specific nodes.             |
| **Scope**         | Node level.                             | Pod level.                               | Pod level (based on node labels).                         |
| **Use Case**      | Prevent workloads from running on nodes. | Allow specific pods to bypass taints.    | Schedule pods to nodes based on labels or conditions.     |
| **Configuration** | Applied to nodes.                       | Applied to pods.                         | Applied to pods via `nodeSelector` or `nodeAffinity`.     |
| **Example**       | Taint: `color=red:NoSchedule`.           | Toleration: `color=red`.                 | Affinity for nodes with `region=us-east-1`.               |

---

## **Summary**
This lab demonstrates:
1. Creating a DaemonSet to deploy pods across all nodes.
2. Using taints and tolerations to control pod scheduling.
3. Comparing taints, tolerations, and node affinity to understand their distinct purposes.

---

**Screenshot References**:
- DaemonSet Creation: ![Placeholder](./screenshots/daemonset-creation.png)
- Tainted Node: ![Placeholder](./screenshots/tainted-node.png)
- Pod Status with Tolerations: ![Placeholder](./screenshots/pod-tolerations.png)
