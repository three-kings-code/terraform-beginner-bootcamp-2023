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

