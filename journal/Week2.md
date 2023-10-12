# Terraform Beginner Bootcamp 2023 - Week 2

## Table of Contents

## Working with Ruby

### Bundler

Bundler is a package manager for ruby.
It is the primary way to install ruby packages (known as gems) for ruby.


#### INstall Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

The you need to run the `bundle install` command

This will install the gems on the systems globally (unlike nodejs which installs packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem version used in this project.

#### Executing ruby scripts int eh context for bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

#### Sinatra 

Sinatra is a micro web framework for ruby to build web-apps.

Its great for mock or development servers or for very simple projects.

you can create a web-server with a single file.

[Sinatra](https://sinatrarb.com/)

## Terratowns Mock Web Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our web server is stored int eh `server.rb` file.

## CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read Update, and Delete

[CRUD - Wiki](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)