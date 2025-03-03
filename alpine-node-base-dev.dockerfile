FROM node:alpine

# Install initial dependencies
RUN apk update && apk add git nano openssh-client zsh

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Copy .zshrc from the host to the image
COPY .zshrc /root/.zshrc

# Set Zsh as the default shell by modifying /etc/passwd
RUN sed -i 's:/bin/ash:/bin/zsh:' /etc/passwd

# COnfigure home directorie for container - will be isolated from the host machine
RUN mkdir /home/devuser && chown -R 1000:1000 /home/devuser  
WORKDIR /home/devuser 

# Create .ssh directory
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# Generate ssh keys
RUN ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa

# Ensure proper permissions
RUN chmod 600 /root/.ssh/id_rsa && chmod 644 /root/.ssh/id_rsa.pub

# Show ssh key
RUN cat /root/.ssh/id_rsa.pub

# Set Zsh as the default shell
CMD ["/bin/zsh"]
