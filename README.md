# Docker cheatsheet commands

Commands from docs.docker.com/get-started

## Part 2 - Containers & Images

* docker build -t friendlyname .  # Create image using this directory's Dockerfile
* docker run -p 4000:80 friendlyname  # Run "friendlyname" mapping port 4000 to 80
* docker run -d -p 4000:80 friendlyname         # Same thing, but in detached mode
* docker container ls                                # List all running containers
* docker container ls -a             # List all containers, even those not running
* docker container stop <hash>           # Gracefully stop the specified container
* docker container kill <hash>         # Force shutdown of the specified container
* docker container rm <hash>        # Remove specified container from this machine
* docker container rm $(docker container ls -a -q)         # Remove all containers
* docker image ls -a                             # List all images on this machine
* docker image rm <image id>            # Remove specified image from this machine
* docker image rm $(docker image ls -a -q)   # Remove all images from this machine
* docker login             # Log in this CLI session using your Docker credentials
* docker tag <image> username/repository:tag  # Tag <image> for upload to registry
* docker push username/repository:tag            # Upload tagged image to registry
* docker run username/repository:tag                   # Run image from a registry

## Part 3 - Services

### About
The Docker service layer is where you define how your services will act in a docker-compose.yml file.

### Commands
* docker stack ls                                            # List stacks or apps
* docker stack deploy -c <composefile> <appname>  # Run the specified Compose file
* docker service ls                 # List running services associated with an app
* docker service ps <service>                  # List tasks associated with an app
* docker inspect <task or container>                   # Inspect task or container
* docker container ls -q                                      # List container IDs
* docker stack rm <appname>                             # Tear down an application
* docker swarm leave --force      # Take down a single node swarm from the manager

## Part 4 - Swarm & Docker Machine

### About
A swarm is a group of nodes that are running docker and are joined into a cluster. Swarms use the master slave model, at least on node is a master and can send commands to nodes.

Docker machine can be used to install docker engine on virtual hosts (local or cloud).

### Commands

* docker-machine create --driver virtualbox myvm1 # Create a VM (Mac, Win7, Linux)
* docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm1 # Win10
* docker-machine env myvm1                # View basic information about your node
* docker-machine ssh myvm1 "docker node ls"         # List the nodes in your swarm
* docker-machine ssh myvm1 "docker node inspect <node ID>"        # Inspect a node
* docker-machine ssh myvm1 "docker swarm join-token -q worker"   # View join token
* docker-machine ssh myvm1   # Open an SSH session with the VM; type "exit" to end
* docker node ls                # View nodes in swarm (while logged on to manager)
* docker-machine ssh myvm2 "docker swarm leave"  # Make the worker leave the swarm
* docker-machine ssh myvm1 "docker swarm leave -f" # Make master leave, kill swarm
* docker-machine ls # list VMs, asterisk shows which VM this shell is talking to
* docker-machine start myvm1            # Start a VM that is currently not running
* docker-machine env myvm1      # show environment variables and command for myvm1
* eval $(docker-machine env myvm1)         # Mac command to connect shell to myvm1
* eval $(docker-machine env -u)     # Disconnect shell from VMs, use native docker
* docker-machine stop $(docker-machine ls -q)               # Stop all running VMs
* docker-machine rm $(docker-machine ls -q) # Delete all VMs and their disk images
* docker-machine scp docker-compose.yml myvm1:~ # Copy file to node's home dir (only required if you use ssh to connect to manager and deploy the app)
* docker-machine ssh myvm1 "docker stack deploy -c <file> <app>"   # Deploy an app using ssh (you must have first copied the Compose file to myvm1)

## Part 5 - Stacks

### About

A stack is a group of interrelated services that share dependencies, and can be orchestrated and scaled together. A single stack is capable of defining and coordinating the functionality of an entire application (though very complex applications may want to use multiple stacks).

### Commands

* docker stack deploy -c <file> <app>  # Deploy an app; command shell must be set to talk to manager (myvm1), uses local Compose file
* docker stack ps <app> # List the tasks in the stack
