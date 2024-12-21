FROM ubuntu:latest

# Create the vscode user and group with specific UIDs/GIDs
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

# Set a password for the vscode user (CHANGE THIS PASSWORD!!!)
USER vscode
RUN echo "vscode:YourStrongPasswordHere" | chpasswd

# Expose the RDP port
EXPOSE 3389

# Start xrdp in the foreground
CMD ["/usr/sbin/xrdp", "-nodaemon"]
