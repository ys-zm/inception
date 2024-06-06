# Overview
This project is about hosting a WordPress website, with a MariaDB backend, on an Nginx webserver. Each component, the website, MariaDB and Nginx run in an isolated Docker container.
It is about setting up a small infrastructure composed of different services under specific rules, inside a virtual machine.

# Docker
## Images
A read-only template with instructions for creating a Docker container. A dockfile is used to create an image and when you change the Dockerfile and rebuild the image, only those layers that have changed are rebuilt.

## Containers
A runnable instance of an image. You can create, start, stop, move or delete a container using the Docker API or CLI. A container is well isolated from other containers and its host machine. It is defined by its image as well as any configuration options you provide when you create / start it.
