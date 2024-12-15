### Lab 25: Role-based Authorization

#### **Objective**
1. Create two users in Jenkins:
   - `user1` with **Admin** privileges.
   - `user2` with **Read-only** privileges.
2. Configure role-based access control to ensure proper segregation of permissions.

---

### **Steps**

#### **1. Enable Role-Based Authorization in Jenkins**
1. Go to Jenkins → **Manage Jenkins → Manage Plugins**.
2. Install the **Role-Based Authorization Strategy** plugin:
   - Navigate to **Available Plugins**, search for `Role-Based Authorization Strategy`, and install it.
3. After installation, navigate to **Manage Jenkins → Configure Global Security**.
4. Under **Authorization**, select **Role-Based Strategy** and click **Save**.

---

#### **2. Create Users**
1. Navigate to **Manage Jenkins → Manage Users → Create User**.
2. Create the following users:
   - **user1**:
     - **Username**: `user1`.
     - **Password**: Provide a strong password.
     - **Email**: Add an email address.
   - **user2**:
     - **Username**: `user2`.
     - **Password**: Provide a strong password.
     - **Email**: Add an email address.

---

#### **3. Configure Roles**
1. Go to Jenkins → **Manage Jenkins → Manage and Assign Roles → Manage Roles**.
2. Add the following roles:
   - **Admin**:
     - Permissions: Check all boxes to grant full administrative privileges.
   - **Read-Only**:
     - Permissions: Check only **Overall → Read** and other relevant read-only options (e.g., View → Read).

---

#### **4. Assign Roles to Users**
1. Navigate to **Manage Jenkins → Manage and Assign Roles → Assign Roles**.
2. Under **Global Roles**:
   - Assign the **Admin** role to `user1`.
   - Assign the **Read-Only** role to `user2`.
3. Save the configuration.

---

### **Verification**
1. Log in as `user1`:
   - Confirm full access to all Jenkins features, including managing jobs, plugins, and system configuration.
2. Log in as `user2`:
   - Confirm that only read-only access is available, and no administrative actions can be performed.

---
