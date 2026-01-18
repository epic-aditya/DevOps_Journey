# DevOps Journey (16-Week Execution Repository)

This repository documents my **16-week DevOps learning journey** focused on **job-ready skills for the Indian market**.

The goal is not just learning tools, but building **strong system fundamentals**, then moving into **cloud infrastructure, automation, Kubernetes, and observability** — with weekly proof-of-work documentation.

✅ **Update Schedule:** I update this repository every **Sunday** with the week’s notes, commands, and artifacts.

---

## What This Repo Will Contain (Incremental)

I’m not creating all folders upfront.  
Each phase directory will be added **only when that phase begins**, so the repo stays clean and reflects real progress.

Planned structure:

- `01-Foundation/` → Linux, Shell, Networking, Git, Python automation  
- `02-Cloud-Infra/` → AWS, Docker, Terraform  
- `03-Automation/` → Jenkins, GitHub Actions, Ansible  
- `04-Orchestration/` → Kubernetes, Helm, Monitoring/Observability

---

## Learning Roadmap (16 Weeks)

### Phase 1: The Iron Foundation (Weeks 1–4)
Focus: becoming fully confident with Linux and core engineering basics.

**Linux**
- Boot process (BIOS/UEFI → GRUB → Kernel → systemd)
- Filesystem hierarchy (FHS) and key directories (`/etc`, `/var`, `/proc`, `/boot`)
- Permissions and ownership model (`chmod`, `chown`, `umask`)
- Process management + resource monitoring (`ps`, `top`, `free`, `df`)
- Service + logs debugging (`systemctl`, `journalctl`, `/var/log/*`)

**Networking**
- OSI model (practical focus: L3, L4, L7)
- IP addressing + CIDR basics
- DNS resolution flow and records
- TCP vs UDP fundamentals

**Git**
- Commit workflow: working directory → staging → commit
- Branching strategies (merge vs rebase basics)
- Conflict resolution and recovery basics

**Python**
- Core syntax + automation thinking
- OS/subprocess basics
- JSON/YAML handling (for DevOps config formats)

---

### Phase 2: Cloud & Infrastructure (Weeks 5–8)
Focus: learn cloud basics manually first, then automate using IaC.

**AWS**
- IAM users, roles, policies (least privilege)
- VPC design basics (subnets, routing, security groups)
- EC2 and S3 workflows

**Build Tools**
- Maven fundamentals (common in Indian enterprise DevOps workflows)
- Artifact and dependency lifecycle awareness

**Docker**
- Dockerfile basics and image-building
- Image optimization and multi-stage builds
- Containers vs images, volumes and networking basics

**Terraform**
- Core workflow: `init → plan → apply → destroy`
- Declarative infrastructure mindset
- Terraform state fundamentals (why state matters)

---

### Phase 3: The Automation Engine (Weeks 9–12)
Focus: real CI/CD pipelines and repeatable configuration automation.

**Jenkins**
- Pipeline-as-code using Jenkinsfile
- Controller/Agent architecture basics
- Webhook-triggered automation

**GitHub Actions**
- YAML workflows: jobs, steps, actions
- Runner basics (hosted vs self-hosted)
- CI/CD patterns for real projects

**Ansible**
- Agentless automation over SSH
- Playbooks, inventory, roles
- Idempotent configuration mindset

---

### Phase 4: Orchestration & Observability (Weeks 13–16)
Focus: operating workloads at scale and measuring system health.

**Kubernetes**
- Cluster architecture (control plane + worker nodes)
- Pods, Deployments, Services
- Scaling and rollout basics

**Helm**
- Charts and templating
- Values-driven deployments

**Monitoring / Observability**
- Prometheus metrics scraping
- Grafana dashboards and alerts
- Basic reliability mindset: measure → detect → debug → recover

---

## Technical Stack
- **OS:** Ubuntu 24.04 LTS  
- **Cloud:** AWS  
- **Tools:** Docker, Kubernetes, Terraform, Jenkins, Ansible, Prometheus, Grafana  

---

## Weekly Proof-of-Work Standards
Each week’s update will include:
- ✅ cleaned notes (Markdown)
- ✅ key commands grouped by purpose
- ✅ troubleshooting notes (failures + fixes if any)
- ✅ scripts or automation artifacts (only when actually built)
- ✅ evidence outputs (logs/reports) when applicable

---

## Progress Tracker
- [ ] Phase 1 (Weeks 1–4)
- [ ] Phase 2 (Weeks 5–8)
- [ ] Phase 3 (Weeks 9–12)
- [ ] Phase 4 (Weeks 13–16)

---

## Why This Repo Exists
This repository is designed to answer one question clearly:

> Can I operate, debug, and automate Linux and cloud systems like a real DevOps engineer?

If the repository proves that through weekly evidence and reproducible work, it’s doing its job.
