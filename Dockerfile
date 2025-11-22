FROM rockylinux/rockylinux:9-ubi-init
LABEL MAINTAINER="wujidadi@gmail.com"

ARG git_version=2.52.0
ARG vim_version=9.1.1924
ARG nano_great_version=8
ARG nano_version=8.7

ARG root_pswd
ARG user_name=rocky
ARG user_pswd

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
    dnf install -y epel-release dnf-utils util-linux util-linux-user glibc-common glibc-langpack-en && \
    dnf install -y --allowerasing sudo bash-completion gcc openssl xz \
    net-tools iputils nmap lsof telnet cronie rsyslog expect zip unzip p7zip p7zip-plugins curl wget tmux \
    zsh ca-certificates less chrony gpg gpgme gnupg2 && \
    echo '' && \
    echo '================================' && \
    echo 'Installing Development Tools ...' && \
    echo '================================' && \
    echo '' && \
    dnf groupinstall -y "Development Tools" && \
    dnf install -y pcre pcre-devel zlib zlib-devel openssl-devel libcurl-devel expat-devel tcl-devel gettext-devel && \
    echo '' && \
    echo '================================' && \
    echo 'Setting root ...' && \
    echo '================================' && \
    echo '' && \
    echo "root:${root_pswd}" | chpasswd && \
    echo '' && \
    echo '==========================================' && \
    echo 'Installing ncurses and S-Lang packages ...' && \
    echo '==========================================' && \
    echo '' && \
    dnf install -y ncurses-devel slang-devel && \
    echo '' && \
    echo '================================' && \
    echo 'Installing newest Git ...' && \
    echo '================================' && \
    echo '' && \
    curl -L https://github.com/git/git/archive/refs/tags/v${git_version}.tar.gz -o /git.tar.gz && \
    tar xvf /git.tar.gz -C / && cd /git-${git_version} && \
    make prefix=/usr all && make prefix=/usr install && \
    cd / && rm -rf /git-${git_version} /git.tar.gz && \
    echo '' && \
    echo '================================' && \
    echo 'Installing newest Vim ...' && \
    echo '================================' && \
    echo '' && \
    cd / && \
    git clone -b v${vim_version} https://github.com/vim/vim.git vim && \
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
    sed -i 's|^#\s*export PATH=\$HOME/bin:/usr/local/bin:\$PATH|export PATH=\$HOME/bin:/usr/local/bin:/usr/local/sbin:\$PATH|g' /root/.zshrc && \
    echo '' && \
    echo '=====================================' && \
    echo 'Changing the default shell to Zsh ...' && \
    echo '=====================================' && \
    echo '' && \
    chsh -s /bin/zsh && \
    /bin/bash -c "touch /root/.oh-my-zsh/cache/{.zsh-update,grep-alias}" && \
    echo '' && \
    echo '================================' && \
    echo 'Changing terminal font color ...' && \
    echo '================================' && \
    echo '' && \
    echo -e '\nexport TERM=xterm-256color' >> ~/.zshrc && \
    echo '' && \
    echo '==================================' && \
    echo 'Installing zsh-autosuggestions ...' && \
    echo '==================================' && \
    echo '' && \
    git clone https://github.com/zsh-users/zsh-autosuggestions /zsh/zsh-autosuggestions && \
    echo -e '\nsource /zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc && \
    echo '' && \
    echo '======================================' && \
    echo 'Installing zsh-syntax-highlighting ...' && \
    echo '======================================' && \
    echo '' && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /zsh/zsh-syntax-highlighting && \
    echo 'source /zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc && \
    echo '' && \
    echo '===============================================================================' && \
    echo "root: Setting Git's default pager to less for displaying unicode characters ..." && \
    echo '===============================================================================' && \
    echo '' && \
    git config --global core.pager 'less --raw-control-chars' && \
    echo '' && \
    echo '================================' && \
    echo 'Creating non-root user ...' && \
    echo '================================' && \
    echo '' && \
    useradd -m -s /bin/zsh -u 1000 ${user_name} && \
    echo "${user_name}:${user_pswd}" | chpasswd && \
    usermod -aG wheel ${user_name} && \
    echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/${user_name} && \
    chmod 0440 /etc/sudoers.d/${user_name} && \
    cp /root/.nanorc /home/${user_name}/.nanorc && \
    chown -R ${user_name}:${user_name} /home/${user_name} && \
    echo ''

# Switch to non-root user
USER ${user_name}
RUN echo '=========================================' && \
    echo 'Installing Oh My Zsh to non-root user ...' && \
    echo '=========================================' && \
    echo '' && \
    echo Y | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/home.bashrc -o /home/${user_name}/.bashrc && \
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/home.vimrc -o /home/${user_name}/.vimrc && \
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/home.zshrc -o /home/${user_name}/.zshrc && \
    sed -i "s|/home/user/.oh-my-zsh|/home/${user_name}/.oh-my-zsh|g" /home/${user_name}/.zshrc && \
    echo -e '\nexport TERM=xterm-256color' >> ~/.zshrc && \
    echo -e '\nsource /zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc && \
    echo 'source /zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc && \
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/myzshtheme.zsh-theme -o /home/${user_name}/.oh-my-zsh/themes/myzshtheme.zsh-theme && \
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/myrootzshtheme.zsh-theme -o /home/${user_name}/.oh-my-zsh/themes/myrootzshtheme.zsh-theme && \
    echo '' && \
    echo '======================================================' && \
    echo 'Changing the default shell of non-root user to Zsh ...' && \
    echo '======================================================' && \
    echo '' && \
    /bin/bash -c "touch /home/${user_name}/.oh-my-zsh/cache/{.zsh-update,grep-alias}" && \
    echo '' && \
    echo '========================================================================================' && \
    echo "Non-root user: Setting Git's default pager to less for displaying unicode characters ..." && \
    echo '========================================================================================' && \
    echo '' && \
    /bin/bash -c "git config --global core.pager 'less --raw-control-chars'" && \
    echo '' && \
    echo '================================' && \
    echo 'Image building finishes' && \
    echo '================================'

WORKDIR /home/${user_name}

CMD [ "/bin/zsh", "-l" ]
