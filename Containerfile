FROM ghcr.io/xscd/fedora-silverblue:37

RUN rpm-ostree cliwrap install-to-root /

ADD dracut_call.sh dracut_call.sh

RUN rpm-ostree override remove gnome-terminal gnome-terminal-nautilus firefox firefox-langpacks && \
    rpm-ostree install gnome-console && \
    rpm-ostree override replace https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-37/x86_64/kernel-6.1.1-225.vanilla.1.fc37.x86_64.rpm https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-37/x86_64/kernel-core-6.1.1-225.vanilla.1.fc37.x86_64.rpm https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-37/x86_64/kernel-modules-6.1.1-225.vanilla.1.fc37.x86_64.rpm https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-37/x86_64/kernel-modules-extra-6.1.1-225.vanilla.1.fc37.x86_64.rpm && \
    ./dracut_call.sh && \
    setsebool -P -N container_manage_cgroup 1 && \
    ostree container commit
