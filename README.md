## azure-architecture-blueprint

Infrastructure defined in Terraform

Documentation for this repository is based mainly on comments in the main.tf terraform template. 

The main.tf template goes through a number of steps to deploy a complete infrastructure. Associated with main.tf is the variables.tf file, which contains all the variables needed for deployment. 

Main.tf uses modules for deploying each of the needed components. The modules in turn, have their own variables.tf which in this context can be seen as place holders (there should be no need to edit these files).


The modules are the following

* Aks: This module deploys the AKS Kubernetes Cluster

* Bastion_host: Creates the bastion host, that will be used to accsess the jump server (which can access the k8s API)

* Container_registry: Creates an Azure Container Registry, for storing container images

* Diagnostic_setting: can be used to define the level of infrastructure logging (not used currently)

* Firewall: Crates the Azure firewall that is used for all egress traffic

* Key_vault: Creates the Azure Key Vault

* Log_analytics: Creates a log-analytics workspace

* Network_security_group: Creates Network Security Groups (NSGs) for the VNETs

* Node_pool: Creates a node pool in the AKS cluster

* Private_dns_zone: Creates the private DNS zones needed for the private endpoints

* Private_endpoint: Create private endpoints (for now, for ACR and Key vault)

* Route_table: Creates a route table the routes egress traffic from AKS to the FW

* Virtual_machine: Creates the VM that is used by the bastion, to access AKS K8s API.

* Virtual_network: Creates the hub VNET

* Virtual_network_peering: Connect the VNETs toghether using peering

* Virtual_network_spoke: Creates the spoke VNET