FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y xrdp xorgxrdp dbus-x11 xfce4 xfce4-goodies

# Configure xrdp to use XFCE
RUN sed -i 's/startwm.sh/startxfce4/' /etc/xrdp/startwm.sh

# Set a password for the default user (ABSOLUTELY ESSENTIAL - CHANGE THIS!)
RUN echo "ubuntu:YourStrongPasswordHere" | chpasswd

# Expose the RDP port
EXPOSE 3389

# Start xrdp in the foreground (important for Codespaces)
CMD ["/usr/sbin/xrdp", "-nodaemon"] #Added -nodaemon
