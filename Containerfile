FROM ghcr.io/xscd/fedora-silverblue:37

RUN rpm-ostree override remove gnome-terminal gnome-terminal-nautilus firefox firefox-langpacks && \
    rpm-ostree install gnome-console && \
    ostree container commit
