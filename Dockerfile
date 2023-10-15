## Custom Dockerfile
FROM consol/debian-xfce-vnc
ENV REFRESHED_AT 2023-10-14

# Switch to root user to install additional software
USER 0

## Install extra software
RUN apt install -y mousepad speedcrunch viewnior engrampa gtkhash gedit meld gimp inkscape mupdf okular openssh-client filezilla && apt clean -y
RUN apt install -y curl less bat tmux && apt clean -y

## switch back to default user
USER 1000