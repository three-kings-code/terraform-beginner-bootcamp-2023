# Terraform Beginner Bootcamp 2023 - Week 0

## Table of Contents

  * [Semantic Versioning](#semantic-versioning)
  * [Install the Terraform CLI](#install-the-terraform-cli)
    + [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
    + [Considerations for Linux Distribution](#considerations-for-linux-distribution)
    + [Refactoring into the Bash Scripts](#refactoring-into-the-bash-scripts)
      - [Shebang](#shebang)
      - [Executions Considerations](#executions-considerations)
      - [Linux Permissions Considerations](#linux-permissions-considerations)
    + [Gitpod Lifecycle - Before, Init, Command](#gitpod-lifecycle---before--init--command)
    + [Working with Env Vars](#working-with-env-vars)
      - [Setting and Upsetting Env Vars](#setting-and-upsetting-env-vars)
      - [Printing Vars](#printing-vars)
      - [Scoping of Env Vars](#scoping-of-env-vars)
      - [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
    + [AWS CLI Installation](#aws-cli-installation)
    + [Steps to create AWS IAM Account with CLI access](#steps-to-create-aws-iam-account-with-cli-access)
- [Terraform Basics](#terraform-basics)
    + [Terraform Registry](#terraform-registry)
    + [Terraform Console](#terraform-console)
      - [Terraform Init](#terraform-init)
      - [Terraform Plan](#terraform-plan)
      - [Terraform Apply](#terraform-apply)
      - [Terraform Destroy](#terraform-destroy)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
  * [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)

## Semantic Versioning

This project is going to use semantic versioning for its tagging. [semver.org](https://semver.org/)

The general format: 

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting fir install.

[Install Terraform CLI](https://developer.hasicorp.com/terrafomr/tutorials/aws-get-started/install-cli)


### Considerations for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to your distribution needs.

[How to check OS Version in Linux](https://www.cyberciti.biz/faq/now-to-check-os-version-in-linux-command-line/)

Example of checking OS Version
```sh
$ cat /etc/os-release 

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into the Bash Scripts

while fixing the Terraform CLI gpg deprecation issues we noticed the installation bash script steps were a considerable amount of code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terafrom_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allows us an easier to debug and execute manual the Terraform CLI install
- This will allow for better portability for the other projects that need to install Terraform CLI.

#### Shebang

A Shebang (pronounced Sha-bang) tells the bash script what program will interpret the script. eg. `#!/bin/bash`

ChatGPT recommended we use this format for bash: `#!/usr/bin/env bash`

- for portability for the different OS distributions
- will search the user's PATH for the bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Executions Considerations

When executing the bash script wer can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli` 

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change the linux permission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively

```sh
chmod 744 ./bin/install_terraform_cli
```

### Gitpod Lifecycle - Before, Init, Command

We need to be careful when using the Init because it will not rerun if we restart an existing workspace

https://www.gotpod.io/doc/configure/workspaces/tasks

### Working with Env Vars

We can list out all environment variables  (Env Vars) using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Upsetting Env Vars

In the terminal wer can set using `export HELLO='world'`

In the terminal we unset using `unset HELLO`

We can set and set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we cna set a env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo. `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of the env vars that you have set in another window.

If you want to Env Vars to persist across all the future bash terminals that are open you need to set env vars in your bash profile. eb. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into the gitpod by storing them in the Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all the bash terminals opened in them workspaces.

You can also set env vars in the `.gitpod.yml` but his can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/gettign-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)


We can check if our AWS credentials are configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload return that looks like this:

```json
{
    "UserId": "AIDSZKGDDUERBARBCBFHI",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/username"
}
```

We'll need to generate AWS CLI credentials form the IAM User in order to use the AWS CLI.

### Steps to create AWS IAM Account with CLI access

To create an IAM follow the below steps

1. Sign in to the AWS Management Console: Log in to your AWS account using your credentials.

2. Navigate to the IAM Console:

 - From the AWS Management Console, click on "Services" and then select "IAM" under the "Security, Identity, & Compliance" section.

3. Create a New IAM User:

 - In the IAM dashboard, click on "Users" in the left navigation pane.
 - Click on the "Add user" button.

4. Set User Details:

 - Enter a username for your new IAM user.
 - Choose the access type. For CLI access, select "Programmatic access."
 - Click "Next: Permissions" to proceed.

5. Attach Permissions:

 - In the "Set permissions" step, select "Add user to group."
 - If you want to provide administrator permissions, you can add the user to the existing "AdministratorAccess" group. Alternatively, you can create a new group with admin permissions if one doesn't exist.
 - Click "Next: Tags" to proceed (you can optionally add tags).

6. Add Tags (Optional):

 - You can add tags to the user for better organization, but it's not mandatory. Click "Next: Review" when you're ready.

7. Review User Details:

 - Review the user's details, including their username, access type, and permissions.
 - If everything looks correct, click "Create user."

8. Access Key and Secret Key:

 - After the user is created, you'll see a confirmation page. Make sure to download the user's access key and secret key. These keys are required for CLI access and should be kept secure.

Now, you've successfully created an IAM user with CLI access and administrator permissions.

[Creating an IAM User in the IAM Console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)
[AWS CLI Configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

Always be cautious with administrator-level permissions, as they grant full control over your AWS resources. Make sure to follow best practices for IAM security and restrict permissions whenever possible to the principle of least privilege.

# Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from teh Terraform registry which is located at [registry.terraform.io](https://registry.terraform.io)

- **Providers** is an interface to APIs that will allow you to create resources with terraform.
- **Modules** are a way to make large amounts of terraform code modular, portable and shareable.

[Random terraform provider](https://registry.terraform.io/providers/hashicorp/random/latest)

### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform`

#### Terraform Init


At the start of a new terraform project we weill run `terraform init` to download the binaries for the terraform providers that we'll use in this project

#### Terraform Plan

`terraform plan`
This will generate out a changeset, about the state of our infrastructure ans what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but ofter you can just ignore outputting.

#### Terraform Apply

`terraform apply`
This will run a plan and pass the changeset to be executed by terraform. Apply should prompt us yes or no

If we want to automatically approve an apply we can proved the auto approve flag `terraform apply --auto-approve`

If there are issue when applying you will need to check the documentation eg. Check to see if there are any naming conventions you need to adhere to

#### Terraform Destroy

`terafrom destroy`
The above command will destroy any configured resources

If we want to automatically approve a destroy we can proved the auto approve flag `terraform destroy --auto-approve`

### Terraform Lock Files

`.terraform.local.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform LOck DIle should be committed to your Version Control System (VSC) eg. Github

### Terraform State Files

`.terraform.tfstate` contain information about the current state of your infrastructure.

This file **should not be committed** to your VCS.

This file can contain sensitive data.

If you lose this file, you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains the binaries of the terraform providers.

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch bash a wiswig view to generate a token. However it does not work expected in Gitpod VsCode in the browser.

The workaround is manually generate a token in Terraform Cloud

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```
We have automated this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)
