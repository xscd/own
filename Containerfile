FROM ghcr.io/cgwalters/fedora-silverblue:37

RUN rpm-ostree override remove gnome-terminal gnome-terminal-nautilus firefox firefox-langpacks && \
    rpm-ostree install gnome-console && \
    rpm-ostree cleanup -m && \
    ostree container commit
