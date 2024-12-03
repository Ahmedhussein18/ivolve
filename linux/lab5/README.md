### Lab5: Disk Management and Logical Volume Setup

This guide walks through the process of attaching a 15GB disk to a VM, partitioning it, and configuring various storage functionalities including filesystems, swap, and Logical Volume Management (LVM).

### Objective

- Attach a 15GB disk to a VM.
- Partition the disk into:
  - 5GB (File system)
  - 5GB (Volume Group for LVM)
  - 3GB (LVM extension)
  - 2GB (Swap space)
- Configure:
  - The first 5GB partition as a file system.
  - The 2GB partition as swap.
  - The second 5GB partition as a Volume Group (VG) with a Logical Volume (LV).
  - Extend the LV by adding the 3GB partition.

### Prerequisites

- A Linux-based virtual machine.
- A 15GB virtual disk attached to the VM.
- Root or sudo access.

### Steps

#### 1. Verify and Partition the Disk

**List Available Disks:**
```bash
lsblk
```

**Identify the new disk (e.g., /dev/sdb).**

**Partition the Disk:**
```bash
sudo fdisk /dev/sdb
```

**Create four primary partitions:**
- 5GB: /dev/sdb1 (File system)
- 5GB: /dev/sdb2 (LVM)
- 3GB: /dev/sdb3 (LVM extension)
- 2GB: /dev/sdb4 (Swap)

**Verify partitions:**
```bash
lsblk
```

#### 2. Configure the File System

**Format `/dev/sdb1`:**
```bash
sudo mkfs.ext4 /dev/sdb1
```

**Mount `/dev/sdb1`:**
```bash
sudo mkdir /mnt/data
sudo mount /dev/sdb1 /mnt/data
```

**Persist the Mount:**
Add this /dev/sdb1 /mnt/data ext4 defaults 0 0 to /etc/fstab

#### 3. Configure the Swap Partition

**Format `/dev/sdb4` as Swap:**
```bash
sudo mkswap /dev/sdb4
```

**Enable the Swap:**
```bash
sudo swapon /dev/sdb4
```

**Persist Swap:**

Add this /dev/sdb4 none swap sw 0 0' to /etc/fstab

#### 4. Configure Logical Volume Management (LVM)

**Initialize `/dev/sdb2` as a Physical Volume (PV):**
```bash
sudo pvcreate /dev/sdb2
```

**Create a Volume Group (VG):**
```bash
sudo vgcreate my_vg /dev/sdb2
```

**Create a Logical Volume (LV):**
```bash
sudo lvcreate -L 5G -n my_lv my_vg
```

**Format the LV:**
```bash
sudo mkfs.ext4 /dev/my_vg/my_lv
```

**Mount the LV:**
```bash
sudo mkdir /mnt/my_lv
sudo mount /dev/my_vg/my_lv /mnt/my_lv
```

**Persist the LV:**
Add this /dev/my_vg/my_lv /mnt/my_lv ext4 defaults 0 0 to /etc/fstab

#### 5. Extend the Logical Volume

**Initialize `/dev/sdb3` as a Physical Volume (PV):**
```bash
sudo pvcreate /dev/sdb3
```

**Add `/dev/sdb3` to the Volume Group:**
```bash
sudo vgextend my_vg /dev/sdb3
```

**Extend the Logical Volume:**
```bash
sudo lvextend -L+3G /dev/my_vg/my_lv
```

**Resize the File System:**
```bash
sudo resize2fs /dev/my_vg/my_lv
```

### Verification

**Check Partition Table:**
```bash
lsblk
```

**Verify Swap:**
```bash
swapon --show
```

**Check LVM Configuration:**
```bash
sudo vgdisplay
sudo lvdisplay
```


