# Week 02 — Networking + Debugging Basics

## Goal (what I was trying to achieve)

This week was about becoming comfortable with the real “site not opening” situation and debugging it like an engineer:

- **L3**: can I reach the machine/network?
    
- **L4**: is the port reachable + is the service listening?
    
- **L7**: is the app behaving correctly (HTTP/DNS)?
    

Main proof: I built **failure simulations** on purpose (Nginx + AWS firewalls) so I can debug production-type problems instead of only reading theory.

---

## What I worked on

### 1) Linux networking basics (local machine / WSL)

- IP address, gateway, route table
- Private vs public IP mental model
- Basic reachability checks
### 2) Ports + transport layer (TCP/UDP)

- what “listening” means
- connection refused vs timeout
- testing ports using `ss` and `nc`
### 3) DNS + HTTP checks

- DNS queries using `dig`
- request validation using `curl -v`
### 4) systemd + logs (real debugging)

- `systemctl status`
- `journalctl -u`
- Nginx logs (`/var/log/nginx/error.log`)
### 5) AWS networking reality (SG vs NACL)

- Security Group = instance-level, **stateful**
- NACL = subnet-level, **stateless**
- rule number priority (100 before 101 etc.)


---

## Mini playbook I followed (fast elimination)

When something fails, I stopped guessing and followed this order:

### Step 1 — L3 check (reach host?)

- `ping`, `ip a`, `ip route`, `traceroute`
### Step 2 — L4 check (port open?)

- `ss -tulnp`, `nc -vz <ip> <port>`

### Step 3 — L7 check (real response?)

- `curl -I`, `curl -v`, `dig +trace`

---

## Main project of the week


**Project:** Nginx on EC2: Break it, Debug it, Fix it (L3→L4→L7)

What I did:

- Installed Nginx on EC2
- Broke connectivity in multiple ways (service stopped, wrong port, config error, AWS rules)
- Debugged each one using a Problem → Analysis → Fix flow

---
## Key commands I used a lot this week

Networking:

- `ip a`
- `ip route`
- `ping -c 4 8.8.8.8`
- `traceroute google.com`
- `ss -tulnp`
- `nc -vz <host> <port>`

DNS + HTTP:

- `dig google.com`
- `dig +trace google.com`
- `curl -I http://localhost`
- `curl -v http://<public-ip>`

systemd + logs:

- `systemctl status nginx`
- `journalctl -u nginx --no-pager -n 50`
- `tail -n 50 /var/log/nginx/error.log`

AWS proof testing:

- From EC2: `curl -I http://localhost`
- From laptop: `curl -I http://<EC2_PUBLIC_IP>`

---

## Week outcome (what I can do now)

I can debug a “website not opening” issue without random changes:

- identify if it’s **routing**, **firewall**, **port**, or **application**
- prove fixes using commands/logs instead of “it works now trust me”