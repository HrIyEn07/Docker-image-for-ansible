FROM ubuntu:latest

# Install SSH server
RUN apt-get update && apt-get install -y openssh-server

# Create SSH directory and add SSH key
RUN mkdir /root/.ssh
COPY ansible-auth-key.pub /root/.ssh/authorized_keys

# Configure SSH server
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin without-password/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && echo "export VISIBLE=now" >> /etc/profile

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
