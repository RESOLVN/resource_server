## Available Servers

a. JupyterLab (ports 8888, 4040 | Token: resolvn) 

b. draw.io/diagrams.net (port 8010)  

c. CyberChef (port 8020)    

d. Mattermost (port 8065) *  

e. Redmine (port 8000) *  

f. Nextcloud (port 8855) *  

g. Jenkins (ports 8100, 8101) *  

h. Gitea (ports 3000, 2222) *  

i. MITRE ATT&CK® Navigator (port 8050)  

j. MITRE ATT&CK® website (port 8095)  

k. OpenCTI (ports 8080, 9000)  

l. Confluence (ports 8090, 8091) *  

m. VECTR (port 8081) *  

---
####  ALL SERVERS with '\*' HAVE DEFAULT ACCOUNT CREDENTIALS BELOW

Username: **resolvn**  
Password: **Resolvn1!Resolvn1!**

---

#### Group 1: Collaboration, File Storage, and Project Management Servers
- (d) Mattermost
- (e) Redmine
- (f) Nextcloud
- (h) Gitea
#### Group 2: Analyst Tool Servers
- (a) JupyterLab
- (b) draw.io/diagrams.net
- (c) CyberChef
#### Group 3: Cyber Threat Intelligence (CTI) Servers
- (i) MITRE ATT@CK® Navigator
- (j) attack.mitre.org website
- (k) OpenCTI v4.2.4
---
####  Example 1: Start a JupyterLab container 
    resolvn@resource-server:~/docker$ docker-compose -f configs/a up -d
#### Example 2: start server group 2 containers
    resolvn@resource-server:~/docker$ docker-compose -f configs/group-2 up -d
#### Example 3: start server groups 1 and 3 containers
    resolvn@resource-server:~/docker$ docker-compose -f configs/group-1 -f configs/group-3 up -d
#### Example 4: start multiple ungrouped server containers
    resolvn@resource-server:~/docker$ docker-compose -f configs/c -f configs/h up -d
#### Example 5: start server group 1 and the MITRE ATT&CK® website containers
    resolvn@resource-server:~/docker$ docker-compose -f configs/group-1 -f configs/j up -d
---

*In some instances, `10.23.51.100` is hardcoded as the resource server IP address. For this reason, it's best to assign this IP address to the VM's second NIC in a Network Spec.*