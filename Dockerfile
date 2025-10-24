### 🧱 Dockerfile  
```dockerfile
FROM ubuntu:22.04

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
      lmms fluxbox x11vnc xvfb novnc websockify python3-pip \
      pulseaudio dbus-x11 && \
    apt clean && rm -rf /var/lib/apt/lists/*

ENV DISPLAY=:0
EXPOSE 8080

CMD Xvfb :0 -screen 0 1280x720x16 & \
    pulseaudio --start && \
    fluxbox & \
    x11vnc -display :0 -nopw -forever -shared -rfbport 5900 & \
    websockify --web /usr/share/novnc/ 8080 localhost:5900 & \
    sleep 2 && lmms
