# How to Deploy the Digital Twin to a New Server

## Prerequisites
You will need three virtual machines running Ubuntu 22.04, each with 4-8GB of RAM and 10GB of disk space for the OS. Additionally, two of these machines should have an extra 50GB of disk space (can be on an additional disk/volume).

The three virtual machines are as follows:
- **gateway**: Runs an Apache transparent proxy server for all services, sets up Let's Encrypt certificates, and provides SSL connections to web apps.
- **web**: Runs the web apps as Docker containers.
- **build**: Functions as a GitLab runner for building and deploying.

Only the **gateway** VM needs an internet-routable IP address. Ensure that you have set the IP address of each system in the Salt pillar hosts file (pillar/hosts.sls) or made sure that the names **gateway**, **web**, and **build** are resolvable via DNS.

These virtual machines can be created using the Salt configuration for this project: [Salt Configuration Repository](https://github.com/NOC-OI/imfe-pilot-salt_config).

### Environment Configuration Files
All the following files should exist in the home directory of the gitlab-runner on the **web** VM. These files are used by various Docker containers at runtime.

#### .tiler-env

#### .env

#### orcid.json

#### tileserver/.env

#### api/.env

## Setting up the Virtual Machines
1. Create your virtual machines. On JASMIN, this can be done via the Cloud dashboard at [JASMIN Cloud Dashboard](https://cloud.jasmin.ac.uk/).
2. Assign an internet IP to the **gateway** VM.
3. Ensure you can SSH into each VM via the **gateway**.
4. On the **build** and **web** VMs, the Docker directory (/var/lib/docker) needs to have plenty of disk space, approximately 50GB, as Docker doesn't always clean up after itself. You can achieve this by either creating a large main disk or creating a second disk and mounting it in /var/lib/docker. If you choose the latter, ensure it gets mounted from the fstab when the VM reboots.

## Setting up Hostnames and SSL Certificates
The following hostnames are used:
- imfe-pilot.noc.ac.uk
- imfe-pilot-mbtiles.noc.ac.uk
- imfe-pilot-tileserver.noc.ac.uk
- imfe-pilot-api.noc.ac.uk

Salt is configured to set up Let's Encrypt for these hostnames but might need additional steps to request the initial certificate. Please note that this hasn't been tested since its initial deployment.

## Setting up Salt
Salt is the configuration management system used to set up the operating system on the VMs. Follow the instructions provided in the [Salt Configuration Repository](https://github.com/NOC-OI/imfe-pilot-salt_config#deploying-to-another-vm).

## Setting up GitLab Runners
You'll need to configure two GitLab runners on the **build** system:
- One should be a Docker runner.
- The other should be a shell runner.
Give these runners the tags "docker" and "shell." The shell runner is used to build Docker containers, while the Docker runner is used to build Python code within a Python Docker container. Ensure that all three GitLab projects (frontend, tileserver, and api_calculations_use_cases) are configured to use these runners.

## Logging into the Docker Registry
Make sure that both the **web** and **build** VMs have logged into the Docker container registry from their gitlab-runner user. If you're using the NOC container registry from a non-NOC IP, you'll need IT to allow this through the firewall.

## Deploying from GitLab
Deploy in the following order: tileserver, api_calculations_use_cases, frontend.
1. Go to each project in turn and click on CI/CD, pipelines, run pipeline.
2. If the frontend fails with a message about the frontend not existing, SSH into the **web** VM and, as the gitlab-runner user, run: `docker run -d -p 8080:80 --name frontend docker-repo.bodc.me/oceaninfo/imfe-pilot/frontend:latest`, then try again.
