# Docker AWS Provisioning Toolkit (`daws`)
------------------------------------------

`daws` toolkit and its playbook has only *one* purpose and one alone which is 
to provision docker-*compose* projects easily on Amazon EC2 service *regardless 
of the AMI or linux distribution used*.

The playbook creates an instance or instances required, deploys the application
 and `docker-composer up -d` it.

## Goals
--------

**Fast:** Quickly get your project from development to deployment stage.

**Generic:** Any docker-compose based app are supported.

**Organised:** Provisioning multiple resources in AWS and tag them efficiently.

## Installation & Setup
-----------------------

This project uses python `virtualenv` package to separate project dependencies
 from rest of your python modules/configuration on your system.

Run the following to setup the virtualenv and install project dependencies

> `./daws setup`

Project requires `python >= 2.7`.

Note: following is a list of dependencies that the install script will pull into
 the virtual environment.

```
* Ansible>=2.0,<3.0
* boto

```

## Quick Start Guide
--------------------

Your *docker-compose* project can be placed anywhere in your localhost, what is
 required is for you to configure the parameters in the deployment YML which you
 will create using the following steps.

Deployment configuration has to be a `yml` file that you feed to the `launch`
 command. Make a copy of the sample file provided as below

> `cp project_vars.yml.sample project-abc-deploy.yml`

#### Project Configuration
--------------------------

Change the parameters in `project-abc-deploy.yml` to setup security groups and
 instance to fit the AWS account you have.

Following mandatory paths for the deployment config needs to be updated for
 successfully deploying the *docker-compose* application.

```
# Project specific parameters
project_prefix: "abc"           # this could be abbreviation of your company
project_name: "ABC Project 1"   # human-readable project name used for resource tagging

project_dirs: 
  src: ./app.sample/
  dest: /opt/app
```

#### AWS Authentication
-----------------------

`aws_profile` variable is used by the playbook to access the AWS credentials and
 other information stored against profiles in `~/.aws/credentials` file.
 Using this way another authentication key generation tool or a script can be
 combined with the playbook. The external script/app needs to write a
 profile section under `~/.aws/credentials` which playbook will use.

## Deployment Process Explained
-------------------------------

Running the playbook: `$ ./daws launch project-abc-deploy.yml` does the following:

1. Creates an instance based on the `project-abc-deploy.yml` with a security
 group as per configuration.
2. Installs Docker-Engine, Docker-Machine and Docker-Compose on the node.
3. Runs tasks such as docker and compose


## Further Reading
------------------

* [DAWS & Docker Application Configuration](docs/daws-docker-app-configuration.md)
* [Sample Application Deployment](docs/sample-app-deployment.md)
 