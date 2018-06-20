# Provisioner for Docker on EC2 instances

This playbook has only *one* purpose and one alone which is to provision 
docker-_compose_ projects easily on Amazon EC2 service _regardless of the AMI or 
linux distribution used_. 

The deploy.yml playbook creates an instance or instances required and deploys 
application and `docker-composer up -d` it.

### Installation & Setup

This project uses python `virtualenv` package to separate project dependancies
from rest of your python modules/configuration on your system.

Run the following to setup the virtualenv and install project dependancies

> `./install`

Project requires `python >= 2.7`.

Note: following is a list of dependancies that the install script will pull into
the virtual environment.

    * Ansible>=2.0,<3.0
    * boto
    * molecule

### Usage

Deployment configuration has to be a `yml` file that you feed to the `launch` 
command. Make a copy of the sample file provided as below

> `cp project_vars.yml.sample project-abc-deploy.yml`

Change the parameters in `project-abc-deploy.yml` according to the AWS account 
you are using and the project requirements you have.

Your _docker-compose_ project can be placed anywhere in your localhost but need
to change the following manadatory paths for the deploy play to successfully 
deploy the _docker-compose_ application.

```
# Project specific parameters
project_prefix: "abc" # this could be abbreviation of your company
project_name: "ABC Project 1" # human readable project name used for resource tagging
project_dirs: 
  src: ./app.sample/
  dest: /opt/app
```

### What it does

Running the playbook: `$ ./launch project-abc-deploy.yml` does the following:

1. Creates an instance based on the `project-abc-deploy.yml` with a security group 
 as per configuration.
2. Installs Docker-Engine, Docker-Machine and Docker-Compose on the node.
3. Runs tasks such as docker and compose
