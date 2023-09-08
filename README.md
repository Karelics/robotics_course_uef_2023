# Base for robotics course


``` bash
xhost +local:`docker inspect --format='{{ .Config.Hostname }}' turtlebot`
```

nvidia-docker2







## Docker

### Installation
Docker Desktop maybe?


[Nvidia-docker2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#setting-up-nvidia-container-toolkit)



### Building the image

Run following command at docker folder of this repo to build the docker image.

``` bash
docker build -t turtlebot:latest -f Dockerfile ../
```

#### Breakdown of the build command

``` bash
docker build
```

is the straight forward the command for building.

``` bash
-t <NAME>:<TAG>
```

Argument `-t` defines the name and a tag of the image which are separated by colon. If no tag is specified, it will be set to `latest` by default. Tags are an easy way to separate different versions of the images.

``` bash
-f Dockerfile
```

Argument `-f` defines the Dockerfile to be used. Works fine with relative paths.

``` bash
../
```

The final piece of the command tells the context where docker will start looking for files. In our case for example in the Dockerfile we do `COPY ros2_ws/src ...` If the build command was ran from the docker folder with the `../` at the end it means that the `COPY` command will copy data from `robotics_course` folder.


VPN may cause issues. `--network=host` fixes the issue but is not the safest way to handle it.

### Running the container(s)

There are two ways to run your image. Straight from command line or with the help of docker-compose.

#### Simplest possible run command from command line:

``` bash
docker run -it turtlebot:latest bash
```

Where `docker run` tells docker that we want to run an container

``` bash
-it
```
Defines an interactive mode, which allows us to use the command line properly inside the image.

``` bash
turtlebot:latest
```
Defines the image which we want to run

``` bash
bash
```
As last we define the command we want to run when the container is started. In this case a bash terminal is started. Here we could basically run any program we have in the image.

Running images from command line like this can be done but if you run more complex systems with docker you would have to add many arguments into the run command and that becomes quite quickly a mess.

#### Docker compose

To solve the issue of messy run command we can use docker compose. For compose we have to create a docker-compose.yml file which will include all the containers we want to launch. This repo includes [an example compose file](docker/docker-compose.yml) which can be used as basis for your work on this course.

To start compose you have to navigate to the docker folder where the file is located at and then run the following command (depending on your version of docker). Rest of the commands on this document will be using the newer command structure so if you have the older version, you will have to add the dash into the commands, or update your docker.

``` bash
docker-compose up
```
Or 
``` bash
docker compose up
```

This will start the container with the command specified in the docker-compose.yml file. You will not have access to the command line in that terminal unless you specify detach argument `-d`.

To shutdown the containers you can run 
``` bash
docker compose down
```
Also simple ctrl+C will do the job if you did not set the detach flag.


``` bash
docker compose logs --follow
```

### Accessing the command line of the container

To access the container via command line you can use
``` bash
docker exec -it turtlebot bash
```

Where `docker exec` defines again the command for docker

``` bash
-it
```
Is again making the session interactive and allows printing into the console.

``` bash
turtlebot
```
Next we have to define the name of the container we want to get into

``` bash
bash
```
And as last thing we define what command we want to execute in that container. In case that we want to access the command line we will use `bash`. 

### Other handy docker commands

To list all docker images on the device use

```
docker images
```

To list all the running containers

```
docker ps
```

To stop a docker container

```
docker rm <container name/ID>
```

To start stopped container

```
docker start <container name/ID>
```

To remove docker container (Cannot be anymore started by `docker start` command)

```
docker rm <container name/ID>
```


Sometimes you might run into situation where docker complains that the container cannot be started because other one with same name is running. To fix that you have to run `docker stop` and `docker rm` for the container.



### Turtlebot simulation launch

``` bash
ros2 launch turtlebot4_ignition_bringup turtlebot4_ignition.launch.py world:=maze
```


``` bash
ros2 launch turtlebot4_ignition_bringup turtlebot4_ignition.launch.py slam:=true nav:=true world:=maze
```




- https://github.com/turtlebot/turtlebot4/tree/humble
- https://github.com/turtlebot/turtlebot4_simulator



``` bash
ros2 launch turtlebot4_ignition_bringup turtlebot4_ignition.launch.py nav2:=true world:=maze map:=/maze.yaml localization:=true rviz:=true
```


