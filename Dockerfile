FROM ubuntu:latest

# Create a non-root user with UID 1000 and group with GID 1000
RUN groupadd -g 1000 vscode && useradd -ms /bin/bash -u 1000 -g 1000 vscode

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    xrdp \
    xorgxrdp \
    dbus-x11 \
    xfce4 \
    xfce4-goodies \
    fonts-noto-cjk \
    x11-xserver-utils \
    && rm -rf /var/lib/apt/lists/*

# Configure xrdp to use XFCE
RUN sed -i 's/startwm.sh/startxfce4/' /etc/xrdp/startwm.sh

# Switch to the non-root user
USER vscode

# Set a password for the non-root user (CHANGE THIS PASSWORD!)
RUN echo "vscode:YourStrongPasswordHere" | chpasswd

# Expose the RDP port
EXPOSE 3389

# Start xrdp in the foreground
CMD ["/usr/sbin/xrdp", "-nodaemon"]
