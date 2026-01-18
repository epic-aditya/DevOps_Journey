# **Operational Excellence in DevOps: A Strategic Execution Framework for Engineering Transformation (2025-2026)**

## **Executive Summary: The Engineering Imperative**

## **Phase 1: The Bedrock – Linux Operating Systems & Networking (Weeks 1-4)**

The first phase addresses the most critical deficit in modern junior engineers: a lack of understanding of the operating system. Cloud platforms (AWS, Azure, GCP) are essentially vast fleets of Linux servers. A DevOps engineer cannot manage what they do not understand. We move beyond surface-level commands to explore the kernel, the file system, and the network stack.1

### **Week 1: Linux Internals and Core Abstractions**

Conceptual Deep Dive:  
The Linux Operating System is composed of the Kernel (managing hardware, memory, and CPU scheduling) and the User Space (where applications and the shell reside). The shell is not just a black box; it is an interpreter that accepts human-readable commands and translates them into system calls that the kernel executes.

* **The File System Hierarchy Standard (FHS):** Unlike Windows, Linux uses a unified file hierarchy rooted at /. Understanding strictly *why* configuration lives in /etc, variable data (logs) in /var, and user binaries in /usr/bin is non-negotiable for troubleshooting.10  
* **File Descriptors & Inodes:** Every file in Linux is identified by an Inode number, and every open file is tracked by a File Descriptor. This concept is crucial later when debugging "Too many open files" errors in production databases.  
* **The Permission Bitmask:** The security model of Linux revolves around Read (4), Write (2), and Execute (1) permissions for User, Group, and Others. The command chmod 755 is not a magic incantation; it is a specific mathematical assertion of access control.11

**Actionable Assignments:**

1. **The "Navigation Maze":** Write a script that creates a deep, complex directory structure (e.g., level1/level2/level3/...). Practice navigating this structure using only relative paths (../../), pushd, and popd. This builds spatial awareness of the file system.  
2. **Permission Hardening:** Create a file owned by root with 700 permissions. Attempt to read it as a standard user. Document the "Permission Denied" error. Then, use sudo chown to transfer ownership and chmod to modify access. This simulates managing secrets keys.

**Mistake Analysis:**

* **The Root Trap:** A common beginner error is running every command with sudo. This bypasses safety checks and can corrupt file ownerships. *Corrective Action:* Apply the Principle of Least Privilege. Only use escalation when modifying system state.12  
* **Relative vs. Absolute:** Confusion between ./script.sh (current directory) and /script.sh (root directory).

### **Week 2: System Administration & Service Management**

Conceptual Deep Dive:  
Servers are not static; they run background processes known as daemons. The systemd init system is the parent of all processes (PID 1\) in modern Linux distributions.

* **Systemd & Systemctl:** Understanding the lifecycle of a service: start (run now), enable (run on boot), stop, and reload (refresh config without stopping).  
* **Process Management:** Every program is a process with a PID. Tools like top, htop, and ps allow the engineer to inspect resource consumption. The kill command sends signals (SIGTERM vs. SIGKILL) to processes.11

Mini-Project 1: The "Web Server Manual Deployment"  
Objective: Deploy a web server without using Docker to understand the raw components.

1. **Installation:** Install Nginx using the package manager (sudo apt install nginx).  
2. **Configuration:** Navigate to /etc/nginx/sites-available. Create a custom configuration file that listens on port 8080\.  
3. **Content:** Create a simple HTML file in /var/www/html displaying "Phase 1 Complete".  
4. **Service Management:** Enable the Nginx service to start on boot. Verify its status with systemctl status nginx.  
5. **Troubleshooting:** Intentionally introduce a syntax error in the config file. Run nginx \-t to detect it. Restart the service and observe the failure. Check logs in /var/log/nginx/error.log.14

### **Week 3: Networking Fundamentals**

Conceptual Deep Dive:  
DevOps is fundamentally about connecting distributed systems. If the network is misunderstood, the system is unmanageable.

* **The OSI Model:** Focusing on Layer 3 (IP), Layer 4 (TCP/UDP), and Layer 7 (HTTP).  
* **IP Addressing:** Understanding CIDR notation (/24, /16), the difference between localhost (127.0.0.1) and the LAN IP (192.168.x.x), and Public vs. Private subnets.  
* **DNS Resolution:** The journey of a URL request. Browser Cache \-\> System Host File (/etc/hosts) \-\> DNS Resolver \-\> Root Server \-\> TLD Server \-\> Authoritative Server.  
* **Ports & Sockets:** A service binds to a specific port. netstat or ss are the stethoscopes used to listen to these bindings.1

**Actionable Assignments:**

1. **Port Scouting:** Use sudo netstat \-tulpn or ss \-tuln to list all ports currently listening on the machine. Identify which PID is holding port 80 or 443\.  
2. **The "Curl" Dissection:** Execute curl \-v https://google.com. Analyze the output line-by-line: the DNS resolution, the TCP connection handshake (SYN/SYN-ACK/ACK), the TLS handshake, the HTTP Request headers (User-Agent, Accept), and the HTTP Response codes (200 OK, 301 Redirect).1  
3. **SSH Key Exchange:** Generate an SSH key pair (ssh-keygen \-t ed25519). Configure a local VM or remote server to accept only key-based authentication, disabling password login in /etc/ssh/sshd\_config.

### **Week 4: Version Control Systems (Git)**

Conceptual Deep Dive:  
Git is the operating system of code. It is a distributed, content-addressable file system.

* **The Graph Theory:** Git is a Directed Acyclic Graph (DAG) of commits. Understanding this helps in visualizing branches and merges.  
* **The Three Stages:** Working Directory (where you type), Staging Area/Index (where you prepare), and Repository (where you save).  
* **Branching Strategies:** Understanding "Trunk-Based Development" (common in DevOps) vs. "GitFlow" (common in legacy software dev).16

**Actionable Assignments:**

1. **Conflict Simulation:** This is a critical stress test.  
   * Create a repo. Create two branches: feature-A and feature-B.  
   * Edit Line 5 of README.md in feature-A. Commit.  
   * Edit Line 5 of README.md in feature-B with *different text*. Commit.  
   * Merge feature-A into main.  
   * Attempt to merge feature-B into main.  
   * **Resolution:** Git will pause and mark the file with conflict markers (\<\<\<\<\<\<\<). You must manually edit the file to resolve the truth, git add, and git commit to finalize.18  
2. **The "Oh Shit" Protocol:** Use git reflog to restore a branch that was accidentally deleted. This is the safety net that separates seniors from juniors.20

**Phase 1 Deliverable: The "Local-Ops" Repository**

* **Structure:**  
  * /01-Linux/health\_check.sh: A shell script (preview of Phase 2\) that prints memory, disk, and CPU usage.  
  * /02-Networking/dns\_trace.txt: The output of a dig trace command explaining each step.  
  * README.md: Documenting the Nginx setup process and the solution to the Git conflict.

**Interview Checkpoint (Phase 1):**

* *Q: What is the difference between a hard link and a soft (symbolic) link?* (Insight: Hard links point to the inode; soft links point to the path. Deleting the original file breaks the soft link but not the hard link).11  
* *Q: How do you check which process is consuming the most memory?* (Answer: top or ps aux \--sort=-%mem).21  
* *Q: Explain the boot process of Linux.* (BIOS \-\> MBR \-\> GRUB \-\> Kernel \-\> Init/Systemd \-\> Runlevel/Target).22

## **Phase 2: The Automation Layer – Scripting & Programming (Weeks 5-8)**

A manual sysadmin types commands; a DevOps engineer writes code that types commands. This phase bridges the gap between interaction and automation. We focus on Bash for system-level glue code and Python for logic-heavy operations.1

### **Week 5: Bash Scripting Fundamentals**

Conceptual Deep Dive:  
Bash scripts are simply a series of commands executed by the shell interpreter.

* **Shebang (\#\!/bin/bash):** The first line that tells the kernel which interpreter to use.24  
* **Exit Codes:** In Linux, "No news is good news." An exit code of 0 means success. Any other number (1-255) indicates failure. Scripts must check $? to determine if the previous command succeeded.  
* **Streams & Redirection:** stdin (0), stdout (1), stderr (2). Using \> to overwrite, \>\> to append, and 2\>&1 to redirect errors to standard output.

**Actionable Assignments:**

1. **The "User Onboarding" Script:** Write a script that accepts a username as an argument ($1).  
   * Checks if the user exists (id "$1").  
   * If not, creates the user, creates their home directory, and adds them to a specific group.  
   * Logs the action with a timestamp to /var/log/user\_setup.log.23  
2. **Backup Automation:** Create a script that tars (tar \-czf) a specific directory, names it with the current date (date \+%F), and moves it to a /backup folder.

### **Week 6: Advanced Bash & Text Processing**

**Conceptual Deep Dive:**

* **The Power of Pipes (|):** Chaining small utilities to perform complex tasks.  
* **Text Processing Triad:**  
  * grep: Filtering lines (search).  
  * awk: Filtering columns (data extraction).  
  * sed: Modifying streams (search and replace).  
* **Cron Scheduling:** The built-in scheduler. Understanding the 5-star syntax (min hour dom mon dow).23

Mini-Project 2: The "Log Analyzer"  
Scenario: You have a massive Nginx access log. You need to identify potential attackers.

1. **Script Logic:**  
   * Use awk to extract the IP address column from the log.  
   * Use sort and uniq \-c to count the occurrences of each IP.  
   * Use sort \-nr to list them descending.  
   * Use head \-n 10 to get the top 10\.  
   * **Automation:** If any IP has \> 500 requests, use iptables or ufw to block it automatically (be careful testing this\!).  
2. **Deliverable:** A script analyze\_logs.sh and a sample log file.24

### **Week 7: Python for DevOps**

Conceptual Deep Dive:  
Bash becomes unwieldy for complex logic, API interactions, or data parsing. Python is the "glue" language of DevOps.

* **Libraries:** os and subprocess for running shell commands; requests for HTTP APIs; json for parsing manifest files; boto3 for AWS automation.  
* **Virtual Environments:** Using venv to isolate dependencies, preventing system-wide library conflicts.

**Actionable Assignments:**

1. **System Monitor 2.0:** Rewrite the "Health Check" script from Phase 1 using Python's psutil library. Output the data as a JSON object, not just text.4  
2. **API Interactor:** Write a Python script that queries the GitHub API to list all repositories for a user. Parse the JSON response and print the URL of each repo.26

### **Week 8: Automation Capstone**

Conceptual Deep Dive:  
Idempotency is the property where an operation can be applied multiple times without changing the result beyond the initial application. A script that creates a user should fail gracefully or do nothing if the user already exists.  
Mini-Project 3: The "Environment Bootstrapper"  
Create a master script (Polyglot: Bash wrapper calling Python scripts) that sets up a fresh Linux machine for development.

* **Requirements:**  
  * Update package lists (apt update).  
  * Install a list of packages defined in a file (packages.txt).  
  * Clone your "dotfiles" repo from GitHub.  
  * Symlink configuration files (.zshrc, .vimrc) to the home directory.  
* **Constraint:** The script must be idempotent. Running it twice should not result in errors or duplicate lines in config files.

**Phase 2 Deliverable: The "Automation-Scripts" Repository**

* Contains user\_create.sh, log\_analyzer.sh, and the bootstrapper/ directory.  
* Documented README explaining how to set executable permissions (chmod \+x).

**Mistake Analysis:**

* **Hardcoding:** Writing /home/shubham/ in scripts. *Correction:* Use $HOME or dynamic paths.  
* **Lack of Error Handling:** Scripts that keep running after a command fails, leading to undefined states. *Correction:* Use set \-e in Bash or try/except blocks in Python.27

**Interview Checkpoint (Phase 2):**

* *Q: How do you debug a shell script?* (Answer: Run it with bash \-x to see the execution trace).23  
* *Q: Write a command to replace "foo" with "bar" in all .txt files in a directory.* (Answer: sed \-i 's/foo/bar/g' \*.txt).28

## **Phase 3: The Containerization Era – Docker & Microservices (Weeks 9-12)**

We now leave the world of "managing servers" and enter the world of "managing applications." Docker revolutionized software delivery by packaging code and dependencies into a portable unit. This is the prerequisite for Kubernetes.29

### **Week 9: Docker Fundamentals & Architecture**

**Conceptual Deep Dive:**

* **VM vs. Container:** A Virtual Machine (VM) includes a full Guest OS and a Hypervisor. A Container shares the Host OS Kernel but isolates the User Space (bins/libs). This makes containers lightweight (MBs vs GBs) and fast (milliseconds vs minutes).9  
* **The Docker Engine:**  
  * **Daemon (dockerd):** The background process that manages images and containers.  
  * **CLI (docker):** The client that talks to the daemon via REST API.  
  * **Registry:** Where images are stored (Docker Hub, ECR).

**Actionable Assignments:**

1. **The Interactive Container:** Run docker run \-it ubuntu bash. You are now inside an isolated Ubuntu environment. Create a file /tmp/test.txt. Exit. Run the same command again. Check for the file. It is gone. *Insight:* Containers are ephemeral (stateless).  
2. **Port Mapping:** Run an Nginx container mapping Host Port 8080 to Container Port 80 (-p 8080:80). Access localhost:8080 from your browser. Stop the container and try to access it.

### **Week 10: The Art of the Dockerfile**

Conceptual Deep Dive:  
A Dockerfile is a script of instructions to build an Image.

* **Layers:** Each instruction (RUN, COPY) creates a read-only layer. Layers are cached.  
* **Instructions:**  
  * FROM: Base image (OS).  
  * WORKDIR: Sets the directory for subsequent commands.  
  * COPY: Moving files from Host to Image.  
  * RUN: Executing build commands (installing packages).  
  * CMD vs ENTRYPOINT: CMD is the default command; ENTRYPOINT makes the container run as an executable.30

**Mini-Project 4: Containerizing a Python Flask App**

1. **App Code:** Create app.py that returns a JSON response "Hello form Docker".  
2. **Dockerfile Construction:**  
   * Use a slim base image (python:3.9-slim) to reduce attack surface.  
   * Install flask via pip.  
   * Expose port 5000\.  
3. **Optimization:** Order matters. Copy requirements.txt and run pip install *before* copying the rest of the source code. This utilizes the **Docker Build Cache** effectively—if you change code but not dependencies, the heavy install step is skipped.31

### **Week 11: Advanced Docker – Networking & Storage**

**Conceptual Deep Dive:**

* **Data Persistence:** Since containers are ephemeral, how do we save database data?  
  * **Volumes:** Managed by Docker, stored in a specific part of the host filesystem. The preferred method.  
  * **Bind Mounts:** Mapping a specific host path to the container. Good for development hot-reloading.32  
* **Networking:** By default, containers are on a "Bridge" network. They can talk to each other if they are on the same network.  
* **Multi-Stage Builds:** A massive optimization technique. Use a heavy image (with compilers/SDKs) to build the artifact, then copy *only* the artifact to a tiny runtime image (like Alpine). This reduces image size from \>1GB to \<50MB.30

**Actionable Assignments:**

1. **The Multi-Stage Challenge:** Take a Go or Java application. Write a Dockerfile with:  
   * FROM golang AS builder: Compile the binary.  
   * FROM alpine: Copy the binary from builder.  
   * Build and compare sizes (docker images).34

### **Week 12: Microservices Capstone (Docker Compose)**

Conceptual Deep Dive:  
docker run is fine for one container. For a stack (Frontend \+ Backend \+ DB), we use Docker Compose. It is a declarative YAML file defining services, networks, and volumes.  
Mini-Project 5: The "Polyglot" Stack  
Deploy a 3-tier application locally.

* **Architecture:**  
  * **Service 1 (Backend):** Python Flask API. Connected to Redis.  
  * **Service 2 (Database):** Redis.  
  * **Service 3 (Frontend):** Nginx serving static HTML that fetches data from the API.  
* **Requirements:**  
  * Define all in docker-compose.yml.  
  * Use a **Named Volume** for Redis so that data persists even if docker-compose down is run.  
  * Use a custom **Network** so Frontend can talk to Backend, but Backend is not exposed publicly (security practice).

**Phase 3 Deliverable: The "Docker-Microservices" Repository**

* Contains the Dockerfile for the API.  
* Contains the docker-compose.yml.  
* Screenshots of the application running and the docker volume ls output.

**Mistake Analysis:**

* **The "Latest" Tag:** Using node:latest in production. *Risk:* One day it upgrades from v14 to v18, breaking your app. *Correction:* Pin versions (node:14.17.0).32  
* **Secrets in Environment:** Hardcoding API keys in the Dockerfile. *Correction:* Use Environment Variables injected at runtime.

**Interview Checkpoint (Phase 3):**

* *Q: What is the difference between an Image and a Container?* (Image is a class; Container is an object/instance).  
* *Q: How do you reduce the size of a Docker image?* (Multi-stage builds, use .dockerignore, combine RUN commands to reduce layers, use Alpine base).31

## **Phase 4: Orchestration – Kubernetes (Weeks 13-16)**

Docker manages a container. Kubernetes (K8s) manages a fleet of containers across a fleet of servers. This is the industry standard for orchestration and arguably the most complex phase.4

### **Week 13: Kubernetes Architecture & The Cluster**

Conceptual Deep Dive:  
K8s is a distributed system. You must understand the components, not just the commands.

* **Control Plane (The Brain):**  
  * **API Server:** The gatekeeper. All commands go here.  
  * **etcd:** The database. Stores the cluster state (key-value store).  
  * **Scheduler:** Decides which node a Pod goes to.  
  * **Controller Manager:** Ensures the actual state matches the desired state.29  
* **Worker Nodes (The Muscle):**  
  * **Kubelet:** The agent running on the node.  
  * **Kube-proxy:** Handles networking rules.  
  * **Container Runtime:** (e.g., containerd/CRI-O) that actually runs the containers.

**Setup:**

* **Minikube vs. Kind:** We recommend **Minikube** for beginners as it simulates a complete cluster well. **Kind** (Kubernetes in Docker) is faster but requires Docker understanding. Install kubectl (the client).9

**Actionable Assignments:**

1. **The First Pod:** A Pod is the smallest unit in K8s (can hold 1+ containers). Write pod.yaml.  
   * Image: nginx.  
   * Command: kubectl apply \-f pod.yaml.  
   * Inspect: kubectl get pods \-o wide.

### **Week 14: Controllers & Workloads**

Conceptual Deep Dive:  
We rarely manage Pods directly. We use higher-level controllers.

* **ReplicaSet:** Ensures X number of pods are always running.  
* **Deployment:** Manages ReplicaSets. Allows for Rolling Updates (zero downtime) and Rollbacks.  
* **StatefulSet:** For databases. Guarantees ordering and stable network IDs (e.g., web-0, web-1).  
* **DaemonSet:** Runs a pod on *every* node (good for logging agents).29

**Actionable Assignments:**

1. **Self-Healing Test:** Create a Deployment with 3 replicas. Manually delete one pod (kubectl delete pod \<name\>). Watch K8s instantly spin up a new one to match the desired state of 3\.  
2. **Rolling Update:** Update the Deployment to use a newer image version. Watch how K8s replaces pods one by one. Roll it back using kubectl rollout undo.36

### **Week 15: Service Discovery & Configuration**

Conceptual Deep Dive:  
Pods are ephemeral; they die and get new IPs. Services provide a stable address.

* **Service Types:**  
  * **ClusterIP:** Internal only (default).  
  * **NodePort:** Opens a port on the Worker Node (static range 30000-32767).  
  * **LoadBalancer:** Asks the Cloud Provider (AWS/Azure) for a real Load Balancer.  
* **Ingress:** A smart router (Layer 7\) that sits in front of services, handling domains (app.example.com) and SSL termination.37  
* **ConfigMaps & Secrets:** Decoupling configuration from code. Injecting environment variables into Pods.29

**Actionable Assignments:**

1. **The ConfigMap Injection:** Modify the Python app to read a GREETING variable. Create a ConfigMap in K8s with GREETING="Hello K8s". Mount it into the Deployment. Update the ConfigMap and restart the pods to see the change.

### **Week 16: Kubernetes Capstone (Helm & Package Management)**

Conceptual Deep Dive:  
Writing raw YAMLs is tedious. Helm is the package manager (like apt for K8s). It uses "Charts" (templates) to deploy complex apps.  
Mini-Project 6: The "Production-Ready" Deployment  
Deploy the Polyglot App to Minikube using Helm concepts.

* **Requirements:**  
  * **Backend:** Deployment \+ ClusterIP Service.  
  * **Database:** StatefulSet \+ Headless Service \+ Persistent Volume Claim (PVC) to ensure data survives pod restarts.  
  * **Frontend:** Deployment \+ NodePort Service.  
  * **Observability:** Install the "Prometheus Stack" using the official Helm Chart to monitor the cluster.  
* **Proof of Work:** A screenshot of the kubectl get all output and the Grafana dashboard running.

**Phase 4 Deliverable: The "K8s-Manifests" Repository**

* Organized folders: /manifests, /helm-charts.  
* Documentation on how to connect to the NodePort service.

**Mistake Analysis:**

* **ImagePullBackOff:** Usually a typo in the image name or a private registry authentication issue. *Troubleshooting:* kubectl describe pod \<name\>.36  
* **CrashLoopBackOff:** The application inside the container is crashing. *Troubleshooting:* kubectl logs \<name\>.  
* **Pending State:** Insufficient CPU/Memory resources on the node. *Troubleshooting:* Check Resource Quotas.

**Interview Checkpoint (Phase 4):**

* *Q: Explain the difference between a Deployment and a StatefulSet.* (StatefulSets maintain sticky identity and storage; Deployments treat pods as interchangeable).  
* *Q: How does a Service find its Pods?* (Using **Labels** and **Selectors**).29  
* *Q: What is a Sidecar container?* (A helper container running in the same Pod, e.g., a log shipper).

## **Phase 5: Infrastructure as Code (IaC) & Cloud (Weeks 17-20)**

We now transition from "Local Ops" to "Cloud Ops." We stop clicking buttons in the AWS Console ("ClickOps") and start defining infrastructure as software using Terraform.4

### **Week 17: AWS Fundamentals (The Free Tier)**

Conceptual Deep Dive:  
We focus on AWS as the market leader, specifically utilizing the Free Tier.

* **IAM (Identity & Access Management):** Users, Roles, and Policies. *Golden Rule:* Never use the Root Account. Create an IAM User with Admin permissions.  
* **EC2 (Elastic Compute Cloud):** Virtual Servers. Understanding Instance Families (t2.micro is free).  
* **VPC (Virtual Private Cloud):** The network boundary. Subnets (Public vs. Private), Internet Gateways, Route Tables, and Security Groups (Firewalls).39

**Actionable Assignments:**

1. **Budget Alarm:** **MANDATORY.** Before launching anything, go to AWS Billing and set up a CloudWatch Alarm to email you if spending exceeds $5.00.41  
2. **Manual Launch:** Launch an EC2 instance manually. Configure the Security Group to allow SSH (Port 22\) only from your IP. SSH into it. Install Docker. Terminate it.

### **Week 18: Terraform Basics**

Conceptual Deep Dive:  
Terraform is a cloud-agnostic IaC tool.

* **HCL (HashiCorp Configuration Language):** Declarative syntax.  
* **Providers:** Plugins that translate HCL into API calls (e.g., aws, google).  
* **The State File (terraform.tfstate):** The "Brain" of Terraform. It maps the real-world resources to your configuration. If this file is lost, Terraform loses track of the infrastructure.42

**Actionable Assignments:**

1. **The First .tf:** Write a main.tf to provision the exact EC2 instance from Week 17\.  
   * Provider: AWS.  
   * Resource: aws\_instance.  
2. **The Workflow:**  
   * terraform init: Download providers.  
   * terraform plan: Dry run (Verify what will happen).  
   * terraform apply: Execute.  
   * terraform destroy: Cleanup (Crucial for cost savings).43

### **Week 19: Advanced Terraform (Modules & State)**

**Conceptual Deep Dive:**

* **Modules:** Reusable components. Instead of copy-pasting VPC code, use a VPC module.  
* **Remote State:** Storing the tfstate file locally is dangerous (what if your laptop breaks?). We store it in an **S3 Bucket** with **DynamoDB Locking** to prevent two people from applying changes simultaneously.44

Mini-Project 8: The Modular VPC  
Create a custom Terraform Module that builds:

* 1 VPC.  
* 2 Public Subnets (in different Availability Zones).  
* 2 Private Subnets.  
* 1 Internet Gateway & Route Table associations.  
* **Output:** The VPC ID.

### **Week 20: IaC Capstone (The 3-Tier Architecture)**

Mini-Project 9: The Infrastructure for the Mega Project  
Use Terraform to provision the environment for the final project.

* **Architecture:**  
  * **VPC:** Use the module from Week 19\.  
  * **Security Groups:**  
    * Web-SG: Allow HTTP/HTTPS from Anywhere (0.0.0.0/0).  
    * App-SG: Allow traffic *only* from Web-SG.  
  * **Compute:** Provision an EKS Cluster (Elastic Kubernetes Service) or a set of EC2 instances.  
  * **User Data:** Use a shell script in the Terraform user\_data field to auto-install Docker and Kubelet on boot.

**Phase 5 Deliverable: The "Terraform-AWS" Repository**

* Structure: main.tf, variables.tf, outputs.tf, modules/.  
* .gitignore MUST exclude \*.tfstate, \*.tfvars, and .terraform/.

**Mistake Analysis:**

* **Committing Secrets:** Pushing AWS\_ACCESS\_KEY to GitHub. *Correction:* Use Environment Variables (export AWS\_ACCESS\_KEY\_ID=...) or AWS Profiles. If you commit a key, revoke it immediately.45  
* **State Drift:** Changing resources manually in the AWS Console. Terraform will detect this as "Drift" and try to revert it. *Correction:* Make all changes via code.

**Interview Checkpoint (Phase 5):**

* *Q: What is the purpose of terraform plan?* (To visualize changes before execution).  
* *Q: How do you handle secrets in Terraform?* (Use generic secrets managers like AWS Secrets Manager or HashiCorp Vault, not plain text).

## **Phase 6: CI/CD & Observability – The Production Pipeline (Weeks 21-24)**

The final phase automates the delivery. We stop running docker build on our laptops. The "Pipeline" does it. We also stop guessing if the server is healthy; we implement monitoring.46

### **Week 21: CI/CD Architecture (Jenkins & GitHub Actions)**

**Conceptual Deep Dive:**

* **Continuous Integration (CI):** Developers merge code \-\> Automated Build \-\> Automated Test. Goal: Fail Fast.  
* **Continuous Delivery (CD):** The artifact is ready to deploy.  
* **Continuous Deployment:** The artifact *is* deployed automatically.16  
* **Jenkins:** The classic, self-hosted, extremely customizable server. Uses a Master-Agent architecture (Master schedules, Agents execute).48  
* **GitHub Actions:** The modern, SaaS native solution. Uses YAML workflows.

**Actionable Assignments:**

1. **Jenkins Setup:** Deploy Jenkins on an EC2 instance (using Terraform from Phase 5). Install the "Docker Pipeline" plugin.  
2. **First Pipeline:** Connect Jenkins to your GitHub repo. Create a Jenkinsfile (Declarative Pipeline) with stages: Checkout, Build, Test.

### **Week 22: The Build & Push Pipeline**

Mini-Project 10: Docker Automation  
Create a pipeline (Jenkins or GitHub Actions) for the Python App.

1. **Trigger:** On push to main branch.  
2. **Step 1:** Run Unit Tests (pytest).  
3. **Step 2:** Build the Docker Image.  
4. **Step 3:** Scan the image for vulnerabilities using **Trivy**.44  
5. **Step 4:** Login to Docker Hub (using Secrets).  
6. **Step 5:** Push the image with the Commit SHA as the tag (not just latest).

### **Week 23: Observability (Prometheus & Grafana)**

**Conceptual Deep Dive:**

* **Monitoring:** "Is the server up?"  
* **Observability:** "Why is the server slow?"  
* **The Stack:**  
  * **Prometheus:** A Time-Series Database. It *pulls* (scrapes) metrics from targets.  
  * **Node Exporter:** A lightweight agent installed on servers to expose CPU/RAM metrics.  
  * **Grafana:** The visualization tool (Dashboards).50

**Actionable Assignments:**

1. **Instrumentation:** Run node\_exporter on the Jenkins EC2 instance.  
2. **Scraping:** Configure Prometheus to scrape the EC2 instance on port 9100\.  
3. **Visualization:** Spin up Grafana. Connect Prometheus as a Data Source. Import Dashboard ID 1860 (Node Exporter Full). Observe the CPU graphs.

### **Week 24: The GitOps Workflow (ArgoCD)**

Conceptual Deep Dive:  
In K8s, we don't run kubectl apply in the CI pipeline. We use GitOps.

* **Principles:** Git is the source of truth. A controller (ArgoCD) inside the cluster pulls changes from Git and syncs the cluster.  
* **Drift Detection:** If someone manually changes the cluster, ArgoCD sees the difference and can auto-heal.44

**Actionable Assignment:**

1. Install ArgoCD on your Minikube/EKS cluster.  
2. Connect it to your K8s-Manifests repo.  
3. Change the replicas: 3 to replicas: 5 in Git. Commit.  
4. Watch ArgoCD detect the change and scale the pods automatically.

## **The Final Capstone: The Mega Project**


**Title:** End-to-End Microservices Deployment with GitOps & Observability

**Objective:** Integrate all 6 phases into a single, verifiable, industry-grade portfolio piece. This is the "Resume Killer."

**Architecture Overview:**

1. **Application:** A "Task Manager" App (Frontend: React, Backend: Node.js, DB: MongoDB).  
2. **Infrastructure:** AWS VPC and EKS Cluster provisioned via **Terraform**.  
3. **Configuration:** **Ansible** (optional) to configure the Jenkins Server / Bastion Host.  
4. **CI Pipeline:** **GitHub Actions** triggers on code commit \-\> Builds Docker Image \-\> Scans with Trivy \-\> Pushes to ECR (Elastic Container Registry).  
5. **CD (GitOps):** The CI pipeline updates the image tag in a separate "Manifests" Repo. **ArgoCD** detects the change and deploys to EKS.  
6. **Observability:** **Prometheus/Grafana** monitoring Pod health; **ELK Stack** (optional) for logs.  
7. **Security:** HTTPS enabled via **Cert-Manager** and Let's Encrypt.

**Execution Steps (2-Week Plan):**

1. **Days 1-3 (Infra):** Write Terraform to spin up VPC and EKS.  
2. **Days 4-6 (App & Docker):** Containerize the apps. Write Helm Charts.  
3. **Days 7-9 (CI/CD):** Setup GitHub Actions and ArgoCD.  
4. **Days 10-12 (Monitoring):** Install Prometheus Stack. Create custom dashboards.  
5. **Days 13-14 (Documentation):** Write the "Case Study" in README.md. Record a 5-minute Loom video demo.

Final Deliverable:  
A GitHub repository with a docs/ folder containing architecture diagrams, screenshots of the pipeline, and the live URL of the application.
