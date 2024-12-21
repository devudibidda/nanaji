FROM ubuntu:latest

# Install necessary packages, including XFCE and xrdp
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    xrdp \
    xorgxrdp \
    dbus-x11 \
    xfce4 \
    xfce4-goodies \
    fonts-noto-cjk \
    && rm -rf /var/lib/apt/lists/*

# Configure xrdp to use XFCE
RUN sed -i 's/startwm.sh/startxfce4/' /etc/xrdp/startwm.sh

# Set a password for the default user (CHANGE THIS PASSWORD!)
RUN echo "ubuntu:YourStrongPasswordHere" | chpasswd

# Expose the RDP port
EXPOSE 3389

# Start xrdp in the foreground
CMD ["/usr/sbin/xrdp", "-nodaemon"]
