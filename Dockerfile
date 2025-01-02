FROM rockylinux/rockylinux:9-ubi
LABEL MAINTAINER="wujidadi@gmail.com"

ARG vim_tag=v9.1.0983
ARG nano_great_version=8
ARG nano_version=8.3

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN echo '' && \
    echo '================================' && \
    echo 'Image building begins ...' && \
    echo '================================' && \
    echo '' && \
    dnf update -y && \
    echo '' && \
    echo '================================' && \
    echo 'Setting date and timezone ...' && \
    echo '================================' && \
    echo '' && \
    ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    echo '' && \
    echo '================================' && \
    echo 'Installing common packages ...' && \
    echo '================================' && \
    echo '' && \
    dnf install -y epel-release dnf-utils util-linux util-linux-user && \
    dnf install -y --allowerasing sudo bash-completion gcc openssl xz \
    net-tools iputils nmap lsof telnet cronie rsyslog expect zip unzip p7zip p7zip-plugins curl wget \
    git zsh ca-certificates less tmux chrony gpg gpgme gnupg2 && \
    echo '' && \
    echo '================================' && \
    echo 'Installing Development Tools ...' && \
    echo '================================' && \
    echo '' && \
    dnf groupinstall -y "Development Tools" && \
    dnf install -y pcre pcre-devel zlib zlib-devel openssl-devel && \
    echo '' && \
    echo '================================' && \
    echo 'Setting root ...' && \
    echo '================================' && \
    echo '' && \
    echo 'root:RootUser' | chpasswd && \
    echo '' && \
    echo '==========================================' && \
    echo 'Installing ncurses and S-Lang packages ...' && \
    echo '==========================================' && \
    echo '' && \
    dnf install -y ncurses-devel slang-devel && \
    echo '' && \
    echo '================================' && \
    echo 'Installing newest Vim ...' && \
    echo '================================' && \
    echo '' && \
    cd / && \
    git clone -b ${vim_tag} https://github.com/vim/vim.git vim && \
    cd vim/src && \
    make && make install && \
    cd / && rm -rf vim && \
    echo '' && \
    echo '================================' && \
    echo 'Installing newest GNU Nano ...' && \
    echo '================================' && \
    echo '' && \
    cd / && \
    curl -OL https://www.nano-editor.org/dist/v${nano_great_version}/nano-${nano_version}.tar.xz && \
    tar xvf nano-${nano_version}.tar.xz -C / && cd nano-${nano_version} && \
    ./configure --enable-utf8 && \
    make && make install && \
    cd .. && rm -rf nano-${nano_version} nano-${nano_version}.tar.xz && \
    echo "include /usr/local/share/nano/*.nanorc" >> /root/.nanorc && \
    echo '' && \
    echo '================================' && \
    echo 'Cleaning dnf cache ...' && \
    echo '================================' && \
    echo '' && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    echo '' && \
    echo '================================' && \
    echo 'Installing Oh My Zsh ...' && \
    echo '================================' && \
    echo '' && \
    echo Y | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/root.bashrc -o /root/.bashrc && \
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/root.vimrc -o /root/.vimrc && \
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/root.zshrc -o /root/.zshrc && \
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/myzshtheme.zsh-theme -o /root/.oh-my-zsh/themes/myzshtheme.zsh-theme && \
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/myrootzshtheme.zsh-theme -o /root/.oh-my-zsh/themes/myrootzshtheme.zsh-theme && \
    echo '' && \
    echo '=====================================' && \
    echo 'Changing the default shell to Zsh ...' && \
    echo '=====================================' && \
    echo '' && \
    chsh -s /bin/zsh && \
    /bin/bash -c "touch /root/.oh-my-zsh/cache/{.zsh-update,grep-alias}" && \
    echo '' && \
    echo '===============================================================================' && \
    echo "root: Setting Git's default pager to less for displaying unicode characters ..." && \
    echo '===============================================================================' && \
    echo '' && \
    git config --global core.pager 'less --raw-control-chars' && \
    echo '' && \
    echo '================================' && \
    echo 'Image building finishes' && \
    echo '================================'

CMD [ "/bin/zsh", "-l" ]
