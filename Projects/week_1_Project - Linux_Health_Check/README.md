# Linux Health Snapshot + Log Hunt (Week 1 DevOps Project)

## Objective
Build a beginner-friendly Linux script that collects a quick system health snapshot and basic log/service troubleshooting information.

This project helped me practice:
- Linux monitoring commands
- systemd service checks
- reading system logs (journalctl)

---

## Features
- Shows system details (date, hostname)
- Checks uptime
- Displays disk usage (`df -h`)
- Displays memory usage (`free -h`)
- Lists top 5 CPU-consuming processes (`ps aux`)
- Shows failed services (`systemctl --failed`)
- Shows last 20 error logs (`journalctl -p err`)

---

## Project Files
- `health_check.sh` → main script
- `sample-report.txt` → saved output report (proof)

---

## How to Run

### 1) Give execute permission
`chmod +x health_check.sh'
### 2) Run the script normally
`./health_check.sh`

---
## Proof / Output

I saved a sample output in:

- `sample-report.txt`

---

## What I Learned

- How to monitor system health using basic Linux commands
    
- How to identify heavy processes using `ps`
    
- How to detect failed services using `systemctl`
    
- How to view recent system errors using `journalctl`
    
- How to generate and store a report output for debugging
