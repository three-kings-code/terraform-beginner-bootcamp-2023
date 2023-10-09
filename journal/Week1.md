# Terraform Beginner Bootcamp 2023 - Week 1

## Table of Contents

## Root Module Structure

Our root module is as follows:

```sh
PROJECT_ROOT
│
├── main.tf            # everything else
├── variables.tf       # stores the structure of input variables
├── providers.tf       # define required providers and their configuration
├── outputs.tf         # stores our outputs
├── terraform.tfvars   # the data of variables we want to load into our Terraform project
└── README.md          # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

### Terraform and Input Variables
### Terraform Cloud Variables

In terraform we can set two kinds of variables:
- Environment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown in the terraform cloud UI

## Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag

We can ise hte `-var` flag to set the input variable or override a variable in the tfvars file eg. `terraform -var user_uuid="my-user_uuid"`

 ### var-file flag

-TODO: research this flag

### terraform.tfvars

This is the default file to load in the terraform variables in the bulk

### auto.tfvars

-TODO: document this functionality for terraform cloud

### order of terraform variables

- TODO: document which terraform variables take precedence  

