Instructions
"docker build -t simple ."
"docker container run --name="nameofyourchoice" -d -p 9000:80 simple"
-> --name is to give a name to your image
-> -d run the container in background
-> -p publish the container's port to the host. In that case 9000 to 80


What happens

- The Dockerfile contains the instructions on how to build you container
- FROM: nginx -> Tells docker to use the nginx image in Docker Hub as your base image (This image contains a pre-configured NGINX server)
- COPY ... -> Tells copies the index.html from your local filesystem to your Docker image (The destination path /usr/share/nginx/html/ is where NGINX serves static files by default)
- EXPOSE ... -> Indicates that which port the container listens on (It's a way of documenting which ports are used by the application, but it doesn't actually map any ports)
