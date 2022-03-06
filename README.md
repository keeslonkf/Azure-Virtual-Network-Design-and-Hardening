## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Red_Team Network Diagram](https://github.com/keeslonkf/GTCS_Project1/blob/0306050e0ce1f7feb867f4003179c33ba9e088c1/Diagrams/NetworkDiagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the install-elk.yml file may be used to install only certain pieces of it, such as Filebeat.

  - ![filebeat-playbook.yml](https://github.com/keeslonkf/GTCS_Project1/blob/b05278a679de40914ab6b0821b1ac092b49e2cf9/Ansible/filebeat-playbook.yml)
  - ![metricbeat-playbook.yml](https://github.com/keeslonkf/GTCS_Project1/blob/b05278a679de40914ab6b0821b1ac092b49e2cf9/Ansible/metricbeat-playbook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly Available, in addition to restricting access to the network. Load balancers work by distributing network traffic across multiple redundant servers so resources can always be accessed by clients. Load balancers typically provide added functionality to combat loss of availability with health probes. These health probes check to make sure each server is functioning properly and able to provide its resources to clients. When a faulty server is discovered, network traffic is rerouted to only the "healthy" servers. Because of its position between the client and server it provides another barrier that acts essentially as another layer of security. Load balancing rules can be used in conjunction with a network security group to harden the system further.

A Jump-Box is a secure machine that is the primary source of administration for a network. It also serves the function of a gateway into a remote network. This is advantageous because in order to connect to the network, a user must authenticate at one focal point.Using this "fanning in" topology significantly reduces exposure to the internet which in turn reduces a network's attack surface. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.
- Filebeat collects log data, specifically about the file system 
- Metric-beat records metrics from the operating system and services such as CPU usage and uptime.

The configuration details of each machine may be found below.

| Name     | Function   | IP Address | Operating System |
|----------|------------|------------|------------------|
| Jump Box | Gateway    | 10.0.0.4   | Linux            |
| Web-1    | DVWA Server| 10.0.0.7   | Linux            |
| Web-2    | DVWA Server| 10.0.0.6   | Linux            |
| Web-3    | DVWA Server| 10.0.0.5   | Linux            |
| ELK      | Monitoring | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- The public IP Address of my Local Machine (87.117.204.79). For security purposes this IP Address was randomly generated for this document. 

Machines within the network can only be accessed by the Jump-box ( 10.0.0.4) as it acts as a gateway to the network. In addition, The Jump-Box has access to the ELK VM server.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 87.117.204.79        |
| Web-1    | No                  | 10.0.0.4             |
| Web-2    | No                  | 10.0.0.4             |
| Web-3    | No                  | 10.0.0.4             |
| ELK      | No                  | 10.0.0.4/52.184.155.0|

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it allows us to easily scale if we want to configure multiple machines at once . This saves us a lot of time and helps maintain uniformity and reduce potential human errors in configuring multiple machines manually. It also allows us to easily destroy and rebuild the same machine in the event that a breach has occurred at the touch of a few keystrokes.

The playbook implements the following tasks:
- Installs Docker, Python3 and docker pip package in that order
- Configures target VM to increase memory and then use more memory to be able to run the ELK container
- Downloads the docker ELK container "sebp/elk:761" and configures the appropriate port mappings
- Enables the Docker service to start on boot so it starts automatically after each restart

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![docker_ps_output.png](https://github.com/keeslonkf/GTCS_Project1/blob/b05278a679de40914ab6b0821b1ac092b49e2cf9/Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 10.0.0.7
- Web-2 10.0.0.6
- Web-3 10.0.0.5

We have installed the following Beats on these machines:
- File-beat
- Metric-beat

These Beats allow us to collect the following information from each machine:

File-beat helps manage log files about the filing system. This data is then sent to Logstash and Elasticsearch. In this project it is used to monitor the Apache server and MySQL database logs generated by the DVWA containers on each Web-VM.

Metric-beat collects Operating System and service metrics such as CPU usage and uptime.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook file to Ansible Control Node.
- $ mkdir /etc/ansible/roles
- $ curl https://gt.bootcampcontent.com/GT-Coding-Boot-Camp/gt-virt-cyber-pt-11-2021-u-lol/-/blob/master/13-Elk-Stack-Project/Activities/Stu_Day_2/Unsolved/Resources/filebeat-playbook.yml > /etc/ansible/roles/filebeat-playbook.yml

- Copy the same playbook for metricbeat and modify as needed
- $ cp /etc/ansible/roles/filebeat-playbook.yml /etc/ansible/roles/metricbeat-playbook.yml

- Update the "hosts" file to include the group "elk" and the Elk server IP address and the group "webservers" and the Web-VM IP addresses.

- $ cd /etc/ansible
- $ nano hosts
-  [webservers]
-  10.0.0.5 ansible_python_interpreter=/usr/bin/python3
-  10.0.0.6 ansible_python_interpreter=/usr/bin/python3
-  10.0.0.7 ansible_python_interpreter=/usr/bin/python3

- [elk]
-  10.1.0.4 ansible_python_interpreter=/usr/bin/python3

- Run the playbook, and navigate to http://52.184.155.0:5601/ to check that the installation worked as expected.
- $ ansible-playbook filebeat-playbook.yml
- $ ansible-playbook metricbeat-playbook.yml
![elkDashboard_snapshot.jpg](https://github.com/keeslonkf/GTCS_Project1/blob/0090daeb4a583945eae5e5f7b09a3e356b7bf39f/Images/elkDashboard_snapshot.JPG)
![kibana_verifyFilebeat3.JPG](https://github.com/keeslonkf/GTCS_Project1/blob/45af183b5ce93e979484965474421c338fbe050f/Images/kibana_verifyFilebeat3.JPG)
![kibana_verifyMetricbeat2.JPG](https://github.com/keeslonkf/GTCS_Project1/blob/c6a0a32a8686003ef4f6799736c856024ba6649c/Images/kibana_verifyMetricbeat2.JPG)
