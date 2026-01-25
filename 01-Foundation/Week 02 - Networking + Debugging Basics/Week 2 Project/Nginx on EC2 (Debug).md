## Why I built this

In real production, failures don’t come with labels like “this is L4 issue”.  
Users just say: **“site not opening”**.

So I built this project as a **production failure simulator**:

- break Nginx connectivity in multiple ways
- debug it with layered thinking (L3/L4/L7)
- prove every fix using commands + logs, not guessing

---
## Setup (what I deployed)

### EC2 + Nginx side

- Ubuntu EC2 instance
- Nginx installed and managed by systemd

Basic install:

- `sudo apt update`
- `sudo apt install nginx -y`
- `systemctl status nginx`

Local validation on EC2:

- `curl -I http://localhost`
- `ss -tulnp | grep :80`

Laptop validation:

- `curl -I http://<EC2_PUBLIC_IP>`

---
## Debugging rule I followed every time

I used this sequence consistently:

1. **L3** — can I reach the machine/network?
2. **L4** — can I reach the port + is something listening?
3. **L7** — does HTTP/DNS behave correctly?

Commands I used repeatedly:

- `ip a`, `ip route`
- `ss -tulnp`
- `curl -I`, `curl -v`
- `systemctl status nginx`
- `journalctl -u nginx`

---

# Failure Scenarios (Problem → Analysis → Fix)

## Scenario 1: Nginx service stopped (L4 symptom)

### Problem

Website not opening.  
From EC2:

- `curl -I http://localhost` fails

### Analysis

Check if nginx is running:

- `systemctl status nginx`

Check if port 80 is listening:

- `ss -tulnp | grep :80`

Expected if broken:

- no nginx process listening on port 80

### Fix

- `sudo systemctl start nginx`

Proof:

- `curl -I http://localhost` should return `HTTP/1.1 200 OK`
- `ss -tulnp | grep :80` shows nginx listening

---

## Scenario 2: Nginx config syntax error (service won’t start)

### Problem

Restart fails:

- `sudo systemctl restart nginx`  
    Then service becomes inactive/failed.

### Analysis

Validate config:

- `sudo nginx -t`

Check logs:

- `journalctl -u nginx --no-pager -n 30`
- `tail -n 50 /var/log/nginx/error.log`


Expected finding:

- syntax error like missing `;` or wrong bracket

### Fix

- correct the config file
- `sudo nginx -t` again (must be OK)
- `sudo systemctl restart nginx`

Proof:

- `systemctl status nginx` shows active
- localhost curl works

---
## Scenario 3: Wrong listen port (8080 instead of 80)

### Problem

From laptop:

- `curl -I http://<EC2_PUBLIC_IP>` fails  
    But nginx is installed.

### Analysis

Check what port nginx is listening on:

- `ss -tulnp | grep nginx`

If it shows `:8080` not `:80`, that’s the mismatch.

Verify:

- `curl -I http://localhost:8080` works
- `curl -I http://localhost:80` fails

### Fix

Edit config and restore correct listen port:

- `sudo nano /etc/nginx/sites-available/default`
- change back to `listen 80;`
- `sudo nginx -t`
- `sudo systemctl restart nginx`

Proof:

- `ss -tulnp | grep :80`
- laptop curl starts working

---
## Scenario 4: Works in EC2, fails from laptop (AWS firewall issue)

This was the most “real AWS” situation.

### Problem

Inside EC2:

- `curl -I http://localhost` ✅ works

From laptop:

- `curl -I http://<EC2_PUBLIC_IP>` ❌ fails (timeout)

### Analysis

This tells me:

- nginx is fine
- port is listening
- but traffic from outside is blocked

So I check AWS layer:

- Security Group inbound for port 80
- subnet rules / NACL if used

Extra check:

- `nc -vz <EC2_PUBLIC_IP> 80`  
    If timeout → firewall drop (SG/NACL)
### Fix

Allow inbound HTTP:

- Security Group: allow TCP 80 from `0.0.0.0/0`  
    Then retest from laptop.

Proof:

- laptop `curl -I http://<EC2_PUBLIC_IP>` returns `HTTP/1.1 200 OK`

---

# AWS Lab Merge: Security Group vs NACL (Stateful vs Stateless)

To understand cloud networking properly, I also did a separate lab where I hosted a python server on port **9080** and controlled traffic using SG and NACL rules. Then I connected that learning back into my Nginx troubleshooting mindset.

## Environment (from my lab)

- Region: ap-south-1 (Mumbai)
- EC2 Public IP used in test: `13.232.34.158`
- App port: `9080`
- VPC CIDR: `10.0.0.0/16`

## SG test (instance firewall)

### Problem

I hosted:

- `python3 -m http.server 9080`

But browser access failed:

- `http://13.232.34.158:9080` ❌ timeout

### Analysis

SG inbound didn’t allow 9080 (default deny).

### Fix

Add SG inbound rule:

- Custom TCP: 9080
- Source: `0.0.0.0/0`

Proof:

- browser loads directory listing
- server logs show `200 OK`

---

## NACL test (subnet firewall)

### Problem

Even after SG allowed 9080, access stopped working again.

### Analysis

NACL inbound rule denied port 9080 (stateless filter).  
Since NACL is checked before SG, it can block traffic even if SG allows.

Also learned rule evaluation order:

- lower rule number wins first match

### Fix

Either:

- remove deny rule, OR
- ensure allow rule number is higher priority (smaller number)

Proof:

- rule 100 allow all + rule 101 deny 9080 → traffic still allowed (because 100 matched first)

---

# What I learned from combining both (real production mindset)

When I see “site not opening” I now think in this order:

### If it fails from everywhere (even inside server)

- nginx down, config error, port not listening

### If it works only inside server but not from laptop

- AWS firewall layer (Security Group / NACL)
- or missing public IP / route issue

### If port connects but HTTP is wrong

- L7 issue: wrong server block, wrong root, reverse proxy, etc.

This project helped me stop random fixes and start doing real troubleshooting.

---

## Commands checklist (used in this repo)

L3:

- `ip a`
- `ip route`
- `ping -c 4 8.8.8.8`
- `traceroute google.com`

L4:

- `ss -tulnp`
- `nc -vz <ip> <port>`

L7:

- `curl -I http://localhost`
- `curl -I http://<public-ip>`
- `curl -v http://<public-ip>`
- `dig google.com`
- `dig +trace google.com`

systemd + logs:

- `systemctl status nginx`
- `journalctl -u nginx --no-pager -n 50`
- `nginx -t`
- `tail -n 50 /var/log/nginx/error.log`