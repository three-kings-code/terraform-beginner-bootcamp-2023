# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

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

In order to make our bash scripts executateable we need to change the linux premission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively

```sh
chmod 744 ./bin/install_terraform_cli
```

### Gitpod Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace

https://www.gotpod.io/doc/configure/workspaces/tasks

### Working with Env Vars

We can list out all environment variables  (Env Vars) using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal wer can set using `export HELLO='world'`

In the terminal we unset using `unset HELLO`

We can set and set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash scritp we cna set a env without writign export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo. `echo $HELLO`

#### Scoping of Env Vars

When yuou open up new bash terminals in VSCode it will not be aware of the env vars that you ahve set in another window.

If you want to Env Vars to persist across all the future bash termainals that are open you need to set env vars in your bash profile. eb. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into the gitpod by storeing them in the Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all the bash terminals openend in them workspaces.

YOu can also set env vars in the `.gitpod.yml` but his can only contain non-senstive env vars.