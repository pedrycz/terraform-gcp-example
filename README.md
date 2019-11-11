# Terraform GCP example
Script generates the following GCP resources:
* network
* firewall rules
* external IP address
* virtual machine with httpd

## Step-by-step setup
1. [Create service account key file](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) for your project and save it as `account.json`
2. Apply Terraform changes
```
terraform init
terraform apply -var="credentials=account.json" -var="project=YOUR_PROJECT_NAME" -auto-approve
```
it should result with something like:
```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

vm-external-ip = 35.189.116.243
```
3. Verify that it works by visiting IP address assigned to your virtual machine

![screenshot](https://user-images.githubusercontent.com/17498216/68586091-2b7c9300-0484-11ea-9f74-5bd3662a901d.png)
