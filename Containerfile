FROM ghcr.io/xscd/fedora-silverblue:38

#RUN rpm-ostree cliwrap install-to-root /

RUN rpm-ostree override remove gnome-terminal gnome-terminal-nautilus firefox firefox-langpacks && \
    rpm-ostree install distrobox gnome-console fastfetch htop && \
    #rpm-ostree override replace https://kojipkgs.fedoraproject.org//work/tasks/544/96130544/kernel-6.1.6-200.fc37.x86_64.rpm https://kojipkgs.fedoraproject.org//work/tasks/544/96130544/kernel-core-6.1.6-200.fc37.x86_64.rpm https://kojipkgs.fedoraproject.org//work/tasks/544/96130544/kernel-modules-6.1.6-200.fc37.x86_64.rpm https://kojipkgs.fedoraproject.org//work/tasks/544/96130544/kernel-modules-extra-6.1.6-200.fc37.x86_64.rpm && \
    #kver=$(ls /lib/modules) && \
    #/usr/libexec/rpm-ostree/wrapped/dracut --tmpdir /tmp/ --no-hostonly --kver $kver --reproducible -v --add ostree -f /tmp/initramfs2.img && \
    #mv /tmp/initramfs2.img /lib/modules/$kver/initramfs.img && \
    rpm-ostree override replace https://kojipkgs.fedoraproject.org//work/tasks/2234/103232234/kernel-6.4.3-200.fc38.x86_64.rpm https://kojipkgs.fedoraproject.org//work/tasks/2234/103232234/kernel-core-6.4.3-200.fc38.x86_64.rpm https://kojipkgs.fedoraproject.org//work/tasks/2234/103232234/kernel-modules-6.4.3-200.fc38.x86_64.rpm https://kojipkgs.fedoraproject.org//work/tasks/2234/103232234/kernel-modules-core-6.4.3-200.fc38.x86_64.rpm https://kojipkgs.fedoraproject.org//work/tasks/2234/103232234/kernel-modules-extra-6.4.3-200.fc38.x86_64.rpm && \
    ostree container commit
