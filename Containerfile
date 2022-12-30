FROM ghcr.io/cgwalters/fedora-silverblue:37

RUN rpm-ostree cliwrap install-to-root /

RUN rpm-ostree override remove gnome-terminal gnome-terminal-nautilus firefox firefox-langpacks && \
    rpm-ostree install gnome-console && \
    rpm-ostree override replace https://kojipkgs.fedoraproject.org//work/tasks/5124/95685124/gtk-update-icon-cache-3.24.36-1.fc37.x86_64.rpm https://kojipkgs.fedoraproject.org//work/tasks/5124/95685124/gtk3-3.24.36-1.fc37.x86_64.rpm && \
    rpm-ostree override replace https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-37/x86_64/kernel-6.1.1-225.vanilla.1.fc37.x86_64.rpm https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-37/x86_64/kernel-core-6.1.1-225.vanilla.1.fc37.x86_64.rpm https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-37/x86_64/kernel-modules-6.1.1-225.vanilla.1.fc37.x86_64.rpm https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-37/x86_64/kernel-modules-extra-6.1.1-225.vanilla.1.fc37.x86_64.rpm && \
    kver=$(ls /lib/modules) && \
    /usr/libexec/rpm-ostree/wrapped/dracut --tmpdir /tmp/ --no-hostonly --kver $kver --reproducible -v --add ostree -f /tmp/initramfs2.img && \
    mv /tmp/initramfs2.img /lib/modules/$kver/initramfs.img && \
    setsebool -P -N container_manage_cgroup 1 && \
    ostree container commit
