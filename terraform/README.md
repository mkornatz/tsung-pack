# Creating a Tsung cluster with Terraform

## Quick Start
When you have Terraform installed, get started right away by applying the plan.

```
# in the directory that contains tsung-cluster.tf
> terraform apply
```

## Configuration
If you don't want to fill in the prompts every time you create infrastructure, you can store your Terraform configuration in a `.tfvars` file. An example is provided in `example.tfvars`.

Applying configuration with a tfvars file:
```
> terraform apply -var-file=myconfig.tfvars
```

[Read the terraform docs](https://www.terraform.io/docs/configuration/variables.html) to understand variables and configuration files.


## Getting info about your infrastructure

This command will list all your instances and their detailed info:

```
> terraform show
```
