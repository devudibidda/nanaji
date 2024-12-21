FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    lsb-release \
    xfce4 \
    xfce4-goodies \
    fonts-noto-cjk \
    x11-xserver-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb
RUN apt-get install -f -y # Fix any dependency issues
RUN rm google-chrome-stable_current_amd64.deb

# Install Chrome Remote Desktop
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb -P /tmp
RUN apt install /tmp/chrome-remote-desktop_current_amd64.deb -y
RUN rm /tmp/chrome-remote-desktop_current_amd64.deb

# Create a virtual display (important!)
RUN Xvfb :0 -screen 0 1024x768x24 &

# Set environment variables for Chrome Remote Desktop
ENV DISPLAY=:0
ENV XAUTHORITY=/home/ubuntu/.Xauthority

# Create .chrome-remote-desktop-session
RUN echo "startxfce4" > /home/ubuntu/.chrome-remote-desktop-session

# Set a password for the default user (CHANGE THIS PASSWORD!)
RUN echo "ubuntu:YourStrongPasswordHere" | chpasswd

# Expose the necessary port (3389 is NOT used by Chrome Remote Desktop)
# Chrome Remote Desktop uses a different port mechanism
# You will need to find the port after the codespace is running
# It is not possible to forward it statically

#CMD ["/usr/sbin/xrdp", "-nodaemon"] # Remove if you are only using Chrome Remote Desktop
CMD ["/opt/google/chrome-remote-desktop/chrome-remote-desktop", "--start", "--desktop", "-- $DISPLAY"]
