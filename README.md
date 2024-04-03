## Azure Architecture Blueprint


This repository provides a comprehensive software-defined infrastructure for deploying Kubernetes on Azure using Azure Kubernetes Service (AKS) and other related services. The entire infrastructure is defined and managed using Terraform.

The primary source of documentation for this repository is the comments within the main.tf Terraform template. For a more in-depth understanding, please refer to this file.

The main.tf template outlines a series of steps to deploy a full-fledged infrastructure. It is associated with the variables.tf file, which houses all the necessary variables for the deployment process.

The main.tf file utilizes various modules to deploy each component of the infrastructure. These modules, in turn, have their own variables.tf files. In this context, these can be viewed as placeholders and typically do not require any modifications.

The modules used are as follows:

* Aks: This module deploys the AKS Kubernetes Cluster.

* Bastion_host: This module creates the bastion host, which is used to access the jump server (that can access the Kubernetes API).

* Container_registry: This module creates an Azure Container Registry, which is used for storing container images.

* Diagnostic_setting: This module can be used to define the level of infrastructure logging (currently not in use).

* Firewall: This module creates the Azure firewall that handles all egress traffic.

* Key_vault: This module creates the Azure Key Vault for secure storage of secrets.

* Log_analytics: This module creates a Log Analytics workspace for comprehensive analytics and insights.

* Network_security_group: This module creates Network Security Groups (NSGs) for the Virtual Networks (VNETs).

* Node_pool: This module creates a node pool within the AKS cluster.

* Private_dns_zone: This module creates the private DNS zones required for the private endpoints.

* Private_endpoint: This module creates private endpoints (currently for Azure Container Registry and Key Vault).

* Route_table: This module creates a route table that directs egress traffic from AKS to the firewall.

* Virtual_machine: This module creates the Virtual Machine (VM) that is used by the bastion host to access the AKS Kubernetes API.

* Virtual_network: This module creates the hub Virtual Network (VNET).

* Virtual_network_peering: This module connects the VNETs together using peering.

* Virtual_network_spoke: This module creates the spoke VNET, which is used for isolating workloads in a hub-and-spoke architecture.