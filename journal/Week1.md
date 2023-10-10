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

The `-var-file` option is a key feature of `terraform apply` that enables you to provide values for Terraform variables from an external file. This separation allows you to keep sensitive or environment-specific values separate from your main configuration files, making your infrastructure management more flexible and secure.

### terraform.tfvars

This is the default file to load in the terraform variables in the bulk

### auto.tfvars

`auto.tfvars` is a special variable file that allows you to automatically load variable values without specifying the `-var-file` flag when running `terraform apply` or `terraform plan`. This feature simplifies the management of variables, particularly in development environments.

#### `auto.tfvars` Usage

Terraform will automatically look for a file named `auto.tfvars` in the same directory as your Terraform configuration files (usually `.tf` files). If it finds this file, it will automatically load variable values from it without any additional flags or commands.

Here's an example of how you can structure your `auto.tfvars` file:

```hcl
# auto.tfvars

example_variable1 = "value1"
example_variable2 = 42
example_variable3 = true
```

### Order of Terraform Variables

the order of variable declaration and assignment can be important, especially when dealing with variable dependencies or overriding values from different sources. Understanding the order of Terraform variables helps ensure that the right values are applied to your infrastructure.

#### Variable Declaration Order

1. **Built-in Variables**: Terraform has a set of built-in variables like `terraform`, which are predefined and cannot be overridden. These built-in variables provide information about the Terraform execution environment.

2. **Variable Blocks**: Variables defined within Terraform configuration files (`.tf`) using `variable` blocks. The order of declaration within these blocks is not significant. However, it's common to group related variables together for clarity.

```hcl
variable "example_variable1" {
  type        = string
  description = "Description of variable 1"
}

variable "example_variable2" {
  type        = number
  description = "Description of variable 2"
}
```

#### Variable Assignment Order

1. **Defaults**: If a variable has a default value specified in its variable block, that default value is applied if no other value is provided.

2. **Environment Variables**: Terraform allows you to set variable values using environment variables. The naming convention is typically TF_VAR_variable_name. Environment variables take precedence over default values but are overridden by explicit variable assignments.

3. **Variable Files**: You can use variable files (e.g., -var-file=variables.tfvars) to provide variable values. Variable files can override both default values and environment variables.

4. **Explicit Variable Assignments**: Variables can also be explicitly assigned values within your Terraform configuration using the var function. Explicit assignments take precedence over all other methods.

## Dealing with Configuration Drift

### What happens if we lose our state file?

If you lose your state file, you will most likely have to tear down all your cloud infrastructure manually.

You can use terraform import but it wont't work for all cloud resources. You need to check the terraform providers documentation for which resources support import
### Fix missing Resources with Terraform Import

`terraform import aws_s3_bucket.my_bucket my-existing-bucket`

[Terraform Import](https://developer.hasicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and deletes or modifies cloud resources manually through ClickOps.

If we run terraform plan it will attempt to put our infrastructure back into the expected state fixing configuration drift
## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```
## Terraform Modules

### Terraform Module Structure

it is recommended to place moduls in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variable to our module.
The module has to declare the terraform variable in its on variable.tf as well as in the the parent module

```hcl
module "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
    user_uuid = var.user_uuid
    bucket_name = var.user_uuid
}
```

### Modules Sources

Using the source we can import the module form various places rg:
- locally
- github
- Terraform Registry

```hcl
module "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
}
```

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may likely produce older examples that could be deprecated. This often affects the providers.

## Working with files in Terraform

### Fileexists function

This is a built in terraform function to check the existance of files.

```hcl
condition = fileexists(var.error_html_filepath)
```

[fileexists](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### filemd5 function

filemd5 is a variant of md5 that hashes the contents of a given file rather than a literal string.

This is similar to `md5(file(filename))`, but because file accepts only UTF-8 text it cannot be used to create hashes for binary files.

```hcl
etag = filemd5(var.index_html_filepath)
```

[filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)



### Path Variables
In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module

[Special Path Variable](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration)

```hcl
resource "aws_s3_object" "website_index" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public.html"
}
```

