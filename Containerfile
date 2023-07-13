FROM quay.io/fedora-ostree-desktops/silverblue:38

RUN rpm-ostree cliwrap install-to-root /

RUN rpm-ostree override replace https://kojipkgs.fedoraproject.org//work/tasks/2234/103232234/kernel-6.4.3-200.fc38.x86_64.rpm https://kojipkgs.fedoraproject.org//work/tasks/2234/103232234/kernel-core-6.4.3-200.fc38.x86_64.rpm https://kojipkgs.fedoraproject.org//work/tasks/2234/103232234/kernel-modules-6.4.3-200.fc38.x86_64.rpm https://kojipkgs.fedoraproject.org//work/tasks/2234/103232234/kernel-modules-core-6.4.3-200.fc38.x86_64.rpm https://kojipkgs.fedoraproject.org//work/tasks/2234/103232234/kernel-modules-extra-6.4.3-200.fc38.x86_64.rpm && \
    ostree container commit
