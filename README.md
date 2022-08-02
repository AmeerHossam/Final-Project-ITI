# Deploy python app on GCP using kubernetes
## Tools used in Project:
- GCP and Terraform
![image](./img1.png)
- Docker and Kubernetes
![image](./img2.png)
## Infastructure: 
- Service-account
- VPC
- 2 private-subnets (management, restricted)
- nat
- cloud-router
- firewall (Allow ssh and http)
- vm (bastion host)
- GCR
- GKE 

## Steps:
### 1) Apply the infrastructure using Terraform 
```bash
$ terraform apply --var-file prod.tfvars
```
### 2) SSH to the bastion host
```bash
gcloud compute ssh --zone "us-central1-a" "terraform-instance"  --tunnel-through-iap --project "gcp-project-356819"
```
### 3) Apply this commands to connect to the GKE cluster
```bash
$ curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-394.0.0-linux-x86_64.tar.gz
$ tar -xf google-cloud-cli-394.0.0-linux-x86_64.tar.gz
$ ./google-cloud-sdk/install.sh
$ ./google-cloud-sdk/bin/gcloud init

# install gcloud packages and update repo
$ sudo apt-get install apt-transport-https ca-certificates gnupg
$ echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
$ curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
$ sudo apt-get update

$ sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin

$ sudo apt-get install kubectl

# connect to the cluster
$ gcloud container clusters get-credentials my-gke-cluster --region us-central1 --project gcp-project-356819

# check cluster connection 
$ kubectl get nodes
```
### 4) Deploy app on kubernetes cluster

### 5) ensure that the app is running
![image](./img3.png)