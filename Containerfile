FROM ghcr.io/xscd/fedora-silverblue:37

RUN rpm-ostree cliwrap install-to-root /

RUN rpm-ostree override remove gnome-terminal gnome-terminal-nautilus firefox firefox-langpacks && \
    rpm-ostree install gnome-console && \
    wget https://copr.fedorainfracloud.org/coprs/calcastor/gnome-patched/repo/fedora-37/calcastor-gnome-patched-fedora-37.repo -O /etc/yum.repos.d/calcastor-gnome-patched-fedora-37.repo && \
    rpm-ostree override replace --experimental --from repo=copr:copr.fedorainfracloud.org:calcastor:gnome-patched mutter && \
    rpm-ostree override replace https://kojipkgs.fedoraproject.org//packages/kernel/6.1.3/200.fc37/x86_64/kernel-6.1.3-200.fc37.x86_64.rpm https://kojipkgs.fedoraproject.org//packages/kernel/6.1.3/200.fc37/x86_64/kernel-core-6.1.3-200.fc37.x86_64.rpm https://kojipkgs.fedoraproject.org//packages/kernel/6.1.3/200.fc37/x86_64/kernel-modules-6.1.3-200.fc37.x86_64.rpm https://kojipkgs.fedoraproject.org//packages/kernel/6.1.3/200.fc37/x86_64/kernel-modules-extra-6.1.3-200.fc37.x86_64.rpm && \
    kver=$(ls /lib/modules) && \
    /usr/libexec/rpm-ostree/wrapped/dracut --tmpdir /tmp/ --no-hostonly --kver $kver --reproducible -v --add ostree -f /tmp/initramfs2.img && \
    mv /tmp/initramfs2.img /lib/modules/$kver/initramfs.img && \
    setsebool -P -N container_manage_cgroup 1 && \
    ostree container commit
