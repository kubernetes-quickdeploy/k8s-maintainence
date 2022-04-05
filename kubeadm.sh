Upgrade the Control Plane
Upgrade kubeadm:

sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubeadm=1.22.2-00
Make sure it upgraded correctly:

kubeadm version
Drain the control plane node:

kubectl drain k8s-control --ignore-daemonsets
Plan the upgrade:

sudo kubeadm upgrade plan v1.22.2
Upgrade the control plane components:

sudo kubeadm upgrade apply v1.22.2
Upgrade kubelet and kubectl on the control plane node:

sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubelet=1.22.2-00 kubectl=1.22.2-00
Restart kubelet:

sudo systemctl daemon-reload
sudo systemctl restart kubelet
Uncordon the control plane node:

kubectl uncordon k8s-control
Verify the control plane is working:

[cloud_user@k8s-control]$ kubectl get nodes
If it shows a NotReady status, run the command again after a minute or so. It should become Ready.


Run the following on the control plane node to drain worker node 1:

[cloud_user@k8s-control]$ kubectl drain k8s-worker1 --ignore-daemonsets --force
You may get an error message that certain pods couldn't be deleted, which is fine.

In a new terminal window, log in to worker node 1:

ssh cloud_user@<WORKER_1_PUBLIC_IP_ADDRESS>
Upgrade kubeadm on worker node 1:

[cloud_user@k8s-worker1]$ sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubeadm=1.22.2-00
[cloud_user@k8s-worker1]$ kubeadm version
Back on worker node 1, upgrade the kubelet configuration on the worker node:

[cloud_user@k8s-worker1]$ sudo kubeadm upgrade node
Upgrade kubelet and kubectl on worker node 1:

[cloud_user@k8s-worker1]$ sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubelet=1.22.2-00 kubectl=1.22.2-00
Restart kubelet:

[cloud_user@k8s-worker1]$ sudo systemctl daemon-reload
[cloud_user@k8s-worker1]$ sudo systemctl restart kubelet
From the control plane node, uncordon worker node 1:

[cloud_user@k8s-control]$ kubectl uncordon k8s-worker1
Worker Node 2
From the control plane node, drain worker node 2:

[cloud_user@k8s-control]$ kubectl drain k8s-worker2 --ignore-daemonsets --force
In a new terminal window, log in to worker node 2:

ssh cloud_user@<WORKER_2_PUBLIC_IP_ADDRESS>
Upgrade kubeadm:

[cloud_user@k8s-worker2]$ sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubeadm=1.22.2-00
[cloud_user@k8s-worker2]$ kubeadm version
Back on worker node 2, perform the upgrade:

[cloud_user@k8s-worker2]$ sudo kubeadm upgrade node
[cloud_user@k8s-worker2]$ sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubelet=1.22.2-00 kubectl=1.22.2-00
[cloud_user@k8s-worker2]$ sudo systemctl daemon-reload
[cloud_user@k8s-worker2]$ sudo systemctl restart kubelet
From the control plane node, uncordon worker node 2:

[cloud_user@k8s-control]$ kubectl uncordon k8s-worker2
Still in the control plane node, verify the cluster is upgraded and working:

[cloud_user@k8s-control]$ kubectl get nodes
If they show a NotReady status, run the command again after a minute or so. They should become Ready.
