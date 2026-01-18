# Week 1: Linux Foundations (Boot + FHS + Core CLI + Permissions + Debugging)

## Objective
Build strong Linux fundamentals required for DevOps work.
This week focused on understanding Linux boot flow, the filesystem hierarchy (FHS),
and developing terminal-first confidence to inspect and debug Linux systems.

The outcome is practical: I can navigate Linux, manage users/permissions, monitor processes,
validate services, and investigate logs with reproducible commands.

---

## Environment Setup (What I actually used)
- Ubuntu Server (for learning + hands-on CLI practice)
- VirtualBox (Ubuntu Server)
- WSL (for practicing ssh)
- Terminal-first workflow (CLI over GUI where possible)

---

## What I Learned + Practiced + Validated

### 1) Linux Boot Process (Conceptual Understanding + Real System Mapping)
**Learned**
- Linux boot stages (high level):
  1. BIOS/UEFI
  2. Bootloader (GRUB)
  3. Kernel initialization
  4. systemd starts as PID 1 and loads services
  5. System becomes operational

**Validated (Evidence)**
- Explored boot-related directories:
  - `ls /boot`
- Used reboot/shutdown in practice:
  - `reboot`, `shutdown now`

---

### 2) Linux Filesystem Hierarchy (FHS) + Directory Meaning (Core Linux Skill)
**Learned**
- Linux paths use `/` (not Windows `\`)
- Everything starts from the root directory `/`
- Knowing directory roles makes production debugging faster (configs/log locations are predictable)

**Practiced (Directory exploration)**
- Root and major folders:
  - `ls /`
- Checked system and service directories:
  - `ls /etc`, `ls /var/log`, `ls /home`, `ls /bin`, `ls /dev`, `ls /snap`

**Validated (FHS understanding for DevOps)**
- Key directories and what they mean:
  - `/etc` → system configs (example: user/service configs)
  - `/var/log` → logs used in debugging
  - `/home` → user home directories
  - `/root` → root user home directory
  - `/boot` → kernel + boot assets
  - `/dev` → devices as files (example: `/dev/null`)
  - `/proc` → live system/process/kernel info (virtual filesystem)
  - `/tmp` → temporary files (often cleared on reboot)

---

### 3) Navigation + File Operations (Terminal Confidence)
**Learned**
- Absolute vs relative paths
- Hidden files and directory shortcuts:
  - `.`, `..`, `~`
- How to safely read files without editing them

**Practiced**
- Navigation + listing:
  - `pwd`, `ls`, `ls -l`, `ls -la`, `cd`
- Creating + deleting directories:
  - `mkdir`, `rm -r`
- Creating files and writing content:
  - `touch`
  - `cat > file.txt` (write while creating)
- Reading large files safely:
  - `cat`, `less`, `more`, `head`, `tail`
- Searching:
  - `find`

**Validated**
- I can locate and inspect system files quickly using CLI.
- I understand what `file` vs `stat` provides:
  - `file` → file type
  - `stat` → owner/perms/size/timestamps

---

### 4) CLI Documentation Tools + Evidence Capture (Engineer Habits)
**Learned**
- How to self-debug using built-in Linux documentation:
  - `man`, `info`
- Why saving outputs builds strong repo evidence and reproducibility

**Practiced**
- Documentation lookup:
  - `man tail`, `man mkdir`, `man rm`, `man umask`
  - `info ls`, `info grep`
- Capturing outputs as evidence:
  - `history | tee psy_history.txt`
  - `ls -la > demo.txt`
  - `ls -R / > demo.txt 2>/dev/null`

**Validated**
- I can produce repeatable command evidence without screenshots.

---

### 5) Users, Groups & Permissions (Interview + Production Core)
**Learned**
- Permission model:
  - `r=4, w=2, x=1`
  - Common patterns: `755`, `644`, `700`
- Ownership vs permissions:
  - owner/group controls access boundaries
- `umask` controls default permissions:
  - it removes permissions, it does NOT add them
  - file default: `666 - umask`
  - directory default: `777 - umask`

**Practiced (Evidence from labs)**
- Identity:
  - `whoami`, `id`, `groups`
- User operations:
  - `adduser/useradd`, `passwd`, `userdel`
- Groups:
  - `groupadd`, `usermod -aG`
- Ownership and permissions:
  - `chmod`, `chown`, `chgrp`
- Default permission behavior:
  - `umask`, `umask -S`

**Validated**
- I created and removed users/groups and checked membership.
- I validated permission changes via:
  - `ls -l`, `stat`
- I intentionally avoided unsafe habits like `chmod 777`.

---

### 6) Processes + Resource Monitoring (Operational Debugging)
**Learned**
- Process basics: PID, CPU, memory consumption
- Signals:
  - SIGTERM (15) for graceful stop
  - SIGKILL (9) as last resort

**Practiced**
- Process listing:
  - `ps`, `ps aux`
- System state:
  - `uptime`, `free -h`, `df -h`
- Kill practice:
  - `kill <pid>`, `kill -9 <pid>`
- Quick filtering/inspection:
  - `ps aux | wc -l`

**Validated**
- I can identify resource-heavy processes and take action safely.

---

### 7) Services + Logs (systemd + journalctl Basics)
**Learned**
- systemd is the service manager used by modern Linux servers.
- Logs are the fastest route to root cause during incidents.

**Practiced (Evidence)**
- Installed and enabled SSH:
  - `sudo apt install openssh-server`
  - `sudo systemctl enable --now ssh`
  - `sudo systemctl status ssh`
- Log monitoring:
  - `tail -f /var/log/auth.log`
  - `tail -f /var/log/syslog`
- Journal analysis:
  - `journalctl -p err -n 20`
- Failure visibility:
  - `systemctl --failed`

**Validated**
- I can validate service state + verify access logs for SSH activity.

---

### 8) Text Processing + Filtering (Signal Extraction)
**Learned**
- DevOps debugging depends on filtering noisy output.
- Redirects and pipes are core tooling.

**Practiced**
- Filtering patterns:
  - `grep`
- Extracting fields:
  - `cut -d: -f1 /etc/passwd`
- Sorting and comparison:
  - `sort`, `diff`
- Redirecting errors:
  - `2>/dev/null`
- Saving output while displaying:
  - `tee`

**Validated**
- I can extract targeted log/system signals using grep + pipes.

---

## Engineering Takeaways (What I can do now)
After Week 1, I can:
- explain Linux boot flow and connect it to systemd/service startup
- understand and navigate Linux filesystem hierarchy (FHS)
- operate comfortably via terminal for file inspection and management
- manage users/groups and correctly debug permission errors
- monitor processes and resource usage for troubleshooting
- validate system services and investigate logs for root cause
- capture reproducible evidence outputs for GitHub documentation
