# CI/CD Pipeline Documentation

There is an automatic gitlab CI/CD pipeline in this project. It is split into this jobs:

## Test: pre-commit

The **Test: pre-commit** job is responsible for executing pre-commit tests.

## Build

The **Build** job is in charge of building the Docker container. The container is tagged based on the container registry name used in the project.

## Deploy

The **Deploy** job handles the deployment process. It pushes the built container to the BODC container registry. Subsequently, it SSHs into the host named "web," retrieves the container, and restarts it. This process requires the presence of a GitLab Runner user on both the build and web virtual machines. An SSH key must also be configured to allow the build to SSH into the web. Please note that while the salt rules repository can create the user and allow manual key generation for login, it does not generate that key. In the event of VM reinstallation, new SSH keys must be created, and the salt rules (salt/user/gitlab-runner.sls) must be updated with the new keys.

## Tests: frontend test

The **Tests: frontend test** job focuses on testing your frontend application. It utilizes the code provided in the repository [https://github.com/NOC-OI/imfe-pilot-frontend_tests](https://github.com/NOC-OI/imfe-pilot-frontend_tests).

### Ensuring Docker is Logged In

To ensure proper functionality, the gitlab-runner user on both the build and web virtual machines must manually log into the Docker registry. This can be achieved using the command `docker login docker-repo.bodc.me` or `docker login uk-london-1.ocir.io`. A user dedicated to the CI/CD pipeline is available for this purpose.

### Firewall Complications

Please be aware of potential complications with the NOC firewall, which only allows requests from the fixed IP of the gateway VM. To overcome this restriction, the deploy script sets up an SSH SOCKS proxy on port 3128 via the gateway for pushing and pulling containers. The Docker configuration is adjusted to use localhost:3128 as a proxy, which requires the SSH tunnel to be running. You can initiate the SSH tunnel with the command `ssh -D 3128 -f -N gateway` before executing any docker login, push, or pull commands. To stop the SSH tunnel, use `pkill -f "ssh -D 3128 -f -N gateway"`.
