FROM ghcr.io/xscd/fedora-silverblue:37

RUN rpm-ostree cliwrap install-to-root /

RUN cd /etc/yum.repos.d/ && curl -LO https://copr.fedorainfracloud.org/coprs/aleasto/waydroid/repo/fedora-37/aleasto-waydroid-fedora-37.repo && \
    rpm-ostree override remove gnome-terminal gnome-terminal-nautilus firefox firefox-langpacks && \
    rpm-ostree install gnome-console waydroid && \
    rpm-ostree override replace https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-37/x86_64/kernel-6.1.1-225.vanilla.1.fc37.x86_64.rpm https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-37/x86_64/kernel-core-6.1.1-225.vanilla.1.fc37.x86_64.rpm https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-37/x86_64/kernel-modules-6.1.1-225.vanilla.1.fc37.x86_64.rpm https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-37/x86_64/kernel-modules-extra-6.1.1-225.vanilla.1.fc37.x86_64.rpm && \
    kver=$(ls /lib/modules) && \
    /usr/libexec/rpm-ostree/wrapped/dracut --tmpdir /tmp/ --no-hostonly --kver $kver --reproducible -v --add ostree -f /tmp/initramfs2.img && \
    mv /tmp/initramfs2.img /lib/modules/$kver/initramfs.img && \
    setsebool -P -N container_manage_cgroup 1 && \
    ostree container commit
