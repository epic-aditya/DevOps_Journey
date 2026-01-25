## L3 — Reachability (IP + Routes + Gateway)

### What L3 means (my own mental model)

**L3 = can packets reach the target machine/network at all?**  
If L3 is broken, nothing else matters.

### IP address

IP = network identity of a machine.

Commands:

- `ip a`
- `hostname -I`

Proof idea:

- if I can see an `inet` address on `eth0`, I have an IP.
### Default gateway + route table

Gateway = “exit door” to outside networks.  
Route table decides where traffic goes next.

Commands:

- `ip route`
- `ip route get 8.8.8.8`

Example expected output:

- `default via <gateway-ip> dev eth0`

### Public vs private IP (AWS context)

Private IP = inside VPC, not reachable from internet  
Public IP = internet facing (if assigned)

Commands (inside EC2):

- `ip a`
- `curl ifconfig.me`

Common mistakes:

- opening SG rules but forgetting EC2 has no public IP
- assuming private IP can be reached from the internet

### L3 troubleshooting commands

- `ping -c 4 8.8.8.8`
- `ping -c 4 google.com`
- `traceroute google.com`

Interpretation:

- ping IP fails → routing/gateway/ISP issue
- ping IP works but ping domain fails → DNS issue

Extra helpful commands (good for real debugging):

- `mtr -rw google.com` (better than traceroute sometimes)
- `ip neigh` / `arp -a` (LAN neighbor/ARP table)

---
## L4 — Ports + TCP/UDP + Listening

### What a port actually is

IP = machine address  
Port = entry point for a program on that machine  
So service = `IP:PORT`

### What “listening” means

Listening = server is waiting and ready to accept incoming connections on a port.

### TCP vs UDP (simple)

TCP:

- handshake (SYN → SYN-ACK → ACK)
- reliable
- used in HTTP/HTTPS/SSH

UDP:

- no handshake
- fast but no guarantee
- used in DNS mostly

### Connection refused vs timeout (huge difference)

**Connection refused** = target replied “no service here”

- usually service down or port closed
- TCP RST is sent back

**Timeout** = no reply at all

- firewall/security group/NACL dropped packets
- routing blackhole

### My core L4 commands

Check what’s listening locally:

- `ss -tulnp`

Test port connectivity:

- `nc -vz 127.0.0.1 9000`
- `nc -vz <public-ip> 80`
- `nc -vz google.com 443`

Extra (useful in real debugging):

- `ss -tn state established`
- `ss -tn state syn-sent` (if stuck here → firewall/drop likely)

Common mistakes:

- assuming “service installed” means it’s listening (not true)
- confusing timeout with refused (they mean different failures)

---

## DNS — Name Resolution Basics (L7-ish but needed early)

### What DNS is doing

DNS converts:  
`domain → IP`

So if DNS fails, even working networks feel broken.

Commands:

- `dig google.com`
- `dig +short google.com`
- `dig A github.com`
- `dig +trace google.com`
- `getent hosts google.com`

Extra useful:

- `cat /etc/resolv.conf`
- `nslookup google.com`

Common failure I simulated:

- bad nameserver entry → domains fail, IP ping still works

---

## L7 — HTTP behavior (what users actually see)

### What L7 means in real debugging

L7 = the application response:

- status codes
- headers
- server behavior (Nginx working? returning correct page?)

### Core commands

Quick status:

- `curl -I http://localhost`
- `curl -I http://<public-ip>`

Deep check:

- `curl -v http://<public-ip>`  
    (shows DNS resolution, TCP connect, request/response headers)

Extra helpful commands:

- `curl --connect-timeout 5 -v http://<ip>`
- `wget -S -O- http://<ip>` (header + body dump)

Common mistakes:

- stopping at “port open” and not checking HTTP result
- ignoring 403/404/500 differences

---

## systemd + logs (this is where truth is)

### Why systemd matters

In Linux servers, **systemd is the service manager**.  
So if Nginx fails, `systemctl` + logs tell the real reason.

Commands:

- `systemctl status nginx`
- `journalctl -u nginx --no-pager -n 50`

Nginx specific:

- `sudo nginx -t` (config syntax test)
- `tail -n 50 /var/log/nginx/error.log`

Common mistakes:

- restarting blindly without running `nginx -t`
- not reading logs and wasting time guessing

---

## AWS — Security Group vs NACL (Traffic Control)

### The clean difference I learned

**Security Group (SG)**

- instance level firewall
- **stateful**
- allow rules only
- return traffic allowed automatically

**Network ACL (NACL)**

- subnet level firewall
- **stateless**
- allow + deny rules
- both inbound and outbound rules matter
- rule number priority matters (100 evaluated before 101)
### Quick mental model (traffic path)

Internet → IGW → NACL (subnet boundary) → SG (instance boundary) → EC2 process

### How I tested it

EC2 ran a python server on port 9080:

- `python3 -m http.server 9080`

If SG didn’t allow 9080 → timeout  
If SG allowed but NACL denied → still timeout (because NACL blocks earlier)

Extra AWS testing commands (from laptop):

- `curl -I http://<public-ip>:9080`
- `nc -vz <public-ip> 9080`