FROM ghcr.io/linuxserver/webtop:ubuntu-focal

USER root

# Install xrdp
RUN apt-get update && \
    apt-get install -y xrdp xorgxrdp dbus-x11

# Configure xrdp to use Xorg
RUN sed -i 's/startwm.sh/startxfce4/' /etc/xrdp/startwm.sh

# Set a password for the default user (IMPORTANT - CHANGE THIS!)
RUN echo "ubuntu:YourStrongPasswordHere" | chpasswd

# Expose the RDP port
EXPOSE 3389

USER abc
