FROM node:latest-slim-debian

# Install initial dependencies
RUN apt-get update
RUN apt-get install -y /
	git /
	nano /
	openssh-client/
