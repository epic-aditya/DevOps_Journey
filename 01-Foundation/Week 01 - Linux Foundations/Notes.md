# Week 1 Lab Notes — Linux Foundations (Boot + FHS + CLI + Permissions + Debugging)

This file documents the commands practiced in Week 1, grouped by operational intent.

---

## A) Command Groups

### 1) Boot + System Identity (Validation)
- `uname` / `uname -a` → kernel and system details
- `uptime` → uptime + load averages
- `hostname` → system hostname
- `date` → system date/time
- `reboot` → reboot system
- `shutdown now` → shutdown immediately

Boot mapping:
- `/boot` contains boot-related files (kernel + boot assets)
- systemd starts services after kernel initialization

---

### 2) Filesystem & Navigation
- `pwd` → print working directory
- `ls` → list directory contents
  - `ls -l` → permissions + ownership view
  - `ls -la` → include hidden files
- `cd` → change directory
- `mkdir` → create directory
- `touch` → create file
- `cp` → copy files
- `mv` → move/rename files
- `rm` / `rm -r` → delete files/directories (careful)
- `find` → search for files

Symbols:
- `.` current directory
- `..` parent directory
- `~` home directory
- `/` root directory

---

### 3) File Inspection + Safe Reading
- `file <name>` → identify file type
- `stat <name>` → ownership, permissions, timestamps, size
- `cat <file>` → print file (small files)
- `less <file>` → safe scroll for big files
- `more <file>` → page view
- `head -n 20 <file>` → first N lines
- `tail -n 20 <file>` → last N lines
- `tail -f <file>` → follow file in real time

Useful patterns:
- `cat > file.txt` → write text while creating file

---

### 4) Linux Directory Hierarchy (FHS Quick Map)
- `/` → root of filesystem
- `/etc` → system configuration
- `/var/log` → logs for troubleshooting
- `/home` → normal user home dirs
- `/root` → root user home
- `/boot` → kernel/boot assets
- `/dev` → device files (example: `/dev/null`)
- `/proc` → live process + kernel info (virtual)
- `/sys` → kernel/hardware interface (virtual)
- `/tmp` → temporary working directory
- `/usr/bin` → installed programs/utilities
- `/mnt` and `/media` → mount points

---

### 5) Users, Groups & Permissions
Identity:
- `whoami` → current user
- `id` → UID/GID and groups
- `groups` → group memberships

Users and groups:
- `adduser <user>` / `useradd -m <user>` → create user
- `passwd <user>` → set password
- `userdel -r <user>` → delete user + home
- `groupadd <group>` / `groupdel <group>` → manage groups
- `usermod -aG <group> <user>` → add user to group

Permissions:
- `chmod 755 file` → rwx r-x r-x
- `chmod 700 file` → rwx --- ---
- `chown user:group file` → change ownership
- `chgrp group file` → change group

Default permissions:
- `umask` / `umask -S` → default permission mask
Rules:
- files default: `666 - umask`
- dirs default:  `777 - umask`
Example:
- umask 022 → file 644, directory 755

---

### 6) Processes & Resource Monitoring
- `ps` → process list
- `ps aux` → full process details
- `top` / `htop` → real-time monitoring
- `free -h` → memory usage
- `df -h` → filesystem disk usage
- `du -sh <dir>` → directory size

Stopping processes:
- `kill <pid>` → terminate process normally
- `kill -9 <pid>` → force kill (last resort)
- `killall <name>` → kill by process name

---

### 7) Services & Logs (systemd + journald)
Service commands:
- `systemctl status <service>`
- `systemctl start|stop|restart <service>`
- `systemctl enable --now <service>`
- `systemctl --failed`

Logs:
- `journalctl -u <service>` → service logs
- `journalctl -p err -n 20` → recent error logs
- `tail -f /var/log/auth.log` → monitor authentication logs
- `tail -f /var/log/syslog` → monitor system logs

Filtering:
- `grep -i error /var/log/syslog` → find error patterns

---

### 8) Text Processing + Evidence Capture
- `grep` → search patterns
- `cut -d: -f1 /etc/passwd` → extract usernames from passwd
- `sort` → sort output
- `diff file1 file2` → compare content
- `wc -l` → line count
- `tee` → save output while displaying

Pipes and redirects:
- `|` pipe output
- `>` overwrite output to file
- `>>` append output
- `2>/dev/null` redirect errors to null

Examples:
- `history | tee psy_history.txt`
- `ls -R / > demo.txt 2>/dev/null`

---

## B) Failure Log
No major failures recorded.

Common fixes used:
- script execution permission:
  - `chmod +x scripts/health_check.sh`
- restricted log/service reads:
  - use `sudo` only when required (least privilege)

---

## C) High-Signal Command Table

| Command | Purpose | When Used |
|--------|---------|----------|
| `ls -la` | list hidden + permission context | verify access and hidden files |
| `stat <file>` | detailed file metadata | ownership/perms/time validation |
| `file <name>` | check file type | identify file vs directory vs symlink |
| `find / -name "<pattern>"` | locate files | fast search on system |
| `chmod +x <script>` | allow script execution | fix permission denied for scripts |
| `chown user:group <file>` | change ownership | correct access control |
| `umask` | check default permission mask | understand new file permissions |
| `ps aux` | list processes with usage | find high CPU/RAM tasks |
| `uptime` | show load + uptime | quick health snapshot |
| `free -h` | memory usage | check memory pressure |
| `df -h` | disk usage | identify space issues |
| `systemctl status ssh` | check service state | validate SSH is active |
| `systemctl --failed` | show failed services | detect service failures quickly |
| `journalctl -p err -n 20` | recent error logs | root-cause direction |
| `tail -f /var/log/auth.log` | live auth monitoring | observe login/SSH attempts |
| `grep -i error /var/log/syslog` | filter error logs | isolate log signals |
