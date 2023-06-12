<h1>Create kubernetes cluster on Azure VMs</h1> 

> Status do Projeto: :heavy_check_mark: Concluido

## Description 

<p align="justify">
  This project was made to create a simple Kubernetes cluster on Azure using virtual machines with a master and as workers as needed. 
</p>

## Functionalities

:heavy_check_mark: Create the resource group on Azure

:heavy_check_mark: Create the virtual network on Azure  

:heavy_check_mark: Create the network security group on Azure

:heavy_check_mark: Create the network interfaces on Azure

:heavy_check_mark: Create the public IPs on Azure

:heavy_check_mark: Create the master node on Azure

:heavy_check_mark: Create the worker node on Azure

## Prerequisites

:warning: [Terraform]
:warning: [Linux OS]
:warning: [Azure account with active subscription]

## How to run :arrow_forward:

On the terminal, clone the project: 

```
git clone https://github.com/nicolaspasqual/Terraform-Azure-vm-k8s.srv.git
```

Generate the Azure credentials to use on Terraform:

```
https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash
```

On the variables file configure:

```
:heavy_check_mark: Environment name to use on the Azure resources
:heavy_check_mark: Amount of workers
:heavy_check_mark: Azure region
:heavy_check_mark: Private key location 
:heavy_check_mark: Public key location 
```

On the project folder, execute the following commands to create the environment:

```
Terraform init
Terraform plan
Terraform apply
```
... 

## How to test the configuration

You will receive the IPs at the end of the run, and now you can connect on the master node:

``` 
ssh terraform@IP
```

You can check the nodes connected on the master executing the following command:

```
Kubectl get nodes
```

## Use cases

studies related to Kubernetes

## Licence

The [MIT License]() (MIT)

Copyright :copyright: 2023 - Create kubernetes cluster on Azure VMs
