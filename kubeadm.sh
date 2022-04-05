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
