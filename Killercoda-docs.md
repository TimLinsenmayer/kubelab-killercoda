Create scenarios for yourself or to share with others.

Our format is Katacoda compatible, so you can simply run your Katacoda scenarios on Killercoda.

To stay up to date with upcoming changes just follow us on Twitter.

hero image
Get Started (as a Creator)
For a detailed tutorial check Get Started. In short:

Add a Github repository to your Killercoda profile
Every push into the repository and specified branch will update the Killercoda scenarios
Write for example JSON, Markdown and Bash. See examples further below
Migrate from Katacoda


Check out our detailed MIGRATION GUIDE

Environments
For faster load times and higher availability use smaller memory/GB images whenever possible!

Name (imageid)	Info	Description
ubuntu		Ubuntu 20.04 with Docker and Podman
2GB environment
ubuntu-4GB	Whenever possible use the 2GB image for faster load times	Ubuntu 20.04 with Docker and Podman
4GB environment
kubernetes-kubeadm-1node		Kubeadm (see version below) cluster with one controlplane, taint removed, ready to schedule workload
2GB environment
kubernetes-kubeadm-1node-4GB	Whenever possible use the 2GB image for faster load times	Kubeadm (see version below) cluster with one controlplane, taint removed, ready to schedule workload
4GB environment
kubernetes-kubeadm-2nodes	Whenever possible use the 2GB image for faster load times	Kubeadm (see version below) cluster with one controlplane and one node, ready to schedule workload
4GB environment
kubernetes-k3s-*	Our K3s environments have been removed and point to Kubeadm ones. Please use the Kubeadm images or Ubuntu and install K3s yourself in scenario install scripts.
K8s Environments Release Cycles
The Kubernetes environments are kept up to date frequently, check Twitter and Slack for notifications.

Creators should make sure their scenarios work on new Kubernetes versions.
The rapid images can be used to test next Kubernetes versions in advance. Make sure to switch back to the default images once these have been updated, so that you'll get time for testing during the next version update.

Name (imageid)	Before 24.10.2024	From 24.10.2024
kubernetes-kubeadm-1node
1.30	1.31
kubernetes-kubeadm-1node-4GB
1.30	1.31
kubernetes-kubeadm-2nodes
1.30	1.31
kubernetes-kubeadm-1node-rapid
1.31	1.31
kubernetes-kubeadm-1node-4GB-rapid
1.31	1.31
kubernetes-kubeadm-2nodes-rapid
1.31	1.31
Our K3s environments have been removed and point to Kubeadm ones. Please use the Kubeadm images or Ubuntu and install K3s yourself in scenario install scripts.
Environment Aliases (Katacoda)
For easier migration from Katacoda we implemented some imageid aliases:

Name (imageid)	(Katacoda) Aliases
ubuntu	ubuntu1804
ubuntu18.04
ubuntu:1804
ubuntu2004
ubuntu:2004
bash
bash1804
bash2004
git
python
go
golang
kubernetes-kubeadm-2nodes
Use kubernetes-kubeadm-1node whenever possible for speed	kubernetes-cluster:1.18
kubernetes-cluster-running:1.18
kubernetes-cluster:1.21
kubernetes-cluster-running:1.21
kubernetes-cluster:1.x
kubernetes-cluster-running:1.x
Scenario Examples
Find more examples in our Github Repository or in action here

Our format is Katacoda compatible, so you can simply run your Katacoda scenarios on Killercoda.

Here we spin up a simple scenario based on Ubuntu 20.04. (Github)

{
  "title": "Ubuntu simple",
  "backend": {
    "imageid": "ubuntu"
  }
}
Here we create a more complex scenario based on Kubernetes. (Github)

{
  "title": "Kubernetes 2node multi-step verification",
  "details": {
    "intro": {
      "text": "intro.md"
    },
    "steps": [
      {
        "title": "Create a pod",
        "text": "step1/text.md",
        "verify": "step1/verify.sh"
      },
      {
        "title": "Delete a pod",
        "text": "step2/text.md",
        "verify": "step2/verify.sh"
      }
    ],
    "finish": {
      "text": "finish.md"
    }
  },
  "backend": {
    "imageid": "kubernetes-kubeadm-2nodes"
  }
}
Visual Editor (IDE)
Every environment has Theia installed, a full-blown in-browser IDE.
Read more about the implementation in our article.



Creators can select the Theia IDE to be shown by default instead of just a simple terminal:

{
  "title": "Use Theia by default",
  "backend": {
    "imageid": "ubuntu"
  },
  "interface": {
    "layout": "ide"
  }
}
Courses (Scenario Groups)
It's possible to group scenarios into courses.

Find course examples in our Github Repository or in action here

The simplest way of grouping scenarios into a course is by just putting them into the same subdirectory.

For more complex structures a structure.json file can be created to:

Control sort order
Reference scenarios from different courses or directories
Override scenario attributes like title or description
Exclude some directories
Once a structure.json is available, only the information from that file will be used. Any scenario or directory that exists outside the structure.json will be ignored.

See our example repository here with structure.json  here and here .

Custom Code Markdown Actions
Check the scenario examples about code blocks and actions here and here

Single line code blocks are automatically copyable per click:

`copy me`
But it can be disabled:

`copying disabled`{{}}
The user can also execute a command per click:

`ls -lh`{{exec}}
Also possible to send a Ctrl+c before running a command:

`whoami`{{exec interrupt}}
It's also possible to let the user copy or execute multiline code blocks:

```
kubectl get pod
kubectl get ns
```{{copy}}
```
cd /tmp
sh run.sh
```{{exec}}
Network Traffic into Environments
To access HTTP services running inside environments, a user can select the item from the terminal nav on top right:



NOTE: the services should be accessible via HTTP and not HTTPS.

Check the scenario examples about network traffic here and here

Creators can include special variables in the scenario markdown to make this easier for the user:

Markdown	Type
{{TRAFFIC_SELECTOR}}
Link to the Traffic/Port page, same as in the top right nav in the terminal
{{TRAFFIC_HOST1_80}}
Link for traffic into host 1 on port 80
{{TRAFFIC_HOST2_4444}}
Link for traffic into host 2 on port 4444
{{TRAFFIC_HOSTX_Y}}
Link for traffic into host X on port Y
[click here]({{TRAFFIC_HOST1_8080}})
Link with text "click here" for traffic into host 1 on port 8080
Creators can generate URLs in bash scripts by using file /etc/killercoda/host:

Code	Type
sed 's/PORT/80/g' /etc/killercoda/host
Generate link for URL on port 80 on the host/VM where this is executed
Host Addresses
The IP addresses of hosts inside environments never change. Every host can reach any other on:

Host	IP
host1	172.30.1.2
host2	172.30.2.2
host3	172.30.3.2
For a two node Kubernetes environment this for example means:

Host	IP
controlplane	172.30.1.2
node01	172.30.2.2
Foreground and Background Scripts
It's possible to run commands or scripts once a user opens a scenario. This allows to setup whatever is needed before the user starts problem solving or learning.

It's not possible to pre-execute code even before a user opens a scenario.

When using foreground scripts, all commands will be shown to the user in the terminal. When using background scripts, the user won't see the executed commands.

You can setup a foreground script which waits for the background script to finish, like done here.

Every step can have a foreground and background script, like shown here.

In case of errors, the background scripts used in the "intro" section will be able to be inspected in the Creator Debug Section. Here are stdout, stderr and error details listed.

Scenario Lifetimes and Limitations
Scenarios can be used for a maximum of 1 hour with FREE and 4 hours with PLUS memberships. The time limit depends on the users and not the creators membership level. If the time is close to end a message will be shown to the user making aware of this.

When the scenario time limit is reached, the user will need to reload the browser tab to get access to a new environment.

Users can use/start as many scenarios as they wish, but only ever one concurrent scenario on FREE and three concurrent scenarios on PLUS memberships.