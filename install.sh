#!/bin/bash
# This has been generated automatically, do not edit.

TARGET_DIR="."

##############################################################################
# Installer header.

function say {
  # write in green, so it is noticeable
  tput setaf 2
  echo $@
  tput sgr0
}
# Update apt cache, if it has not been updated in a while
if [ "$[$(date +%s) - $(stat -c %Z /var/lib/apt/periodic/update-success-stamp)]" -ge $((24*60*60)) ]; then
  say "Apt cache is outdated. Updating - I will need sudo."
  sudo apt-get update
fi
# Install all necessary libraries
say "Installing dependencies. I will need sudo."
sudo apt-get install -y sharutils
say "Uncompressing payload."
# Decompressing
match=$(grep --text --line-number "^DATA:$" $0 | cut -d : -f 1)
payload_start=$((match + 1))
tail -n +$payload_start $0 | uudecode | tar xzf - -C ${TARGET_DIR}
say "Running installer."
##############################################################################
# Installer.


say "Installing utils."
sudo apt-get install -y htop python-pip python-dev git tree xinput


say "Installing Powerline."
if [ ! -f .local/bin/powerline ]; then
    sudo apt-get install -y python-pip git python-dev fontconfig
    pip install --user powerline-status
    git clone https://github.com/powerline/fonts /tmp/fonts
    if [ ! -d /tmp/fonts ]; then
        exit 1
    fi
    pushd /tmp/fonts
    ./install.sh
    fc-cache -vf ~/.fonts/
    popd
    . ~/.bashrc
else
    say 'Skipping, already installed.'
fi


say "Installing and configuring IPython."
if ! which ipython; then
    sudo apt-get install -y ipython ipython3
else
    say 'Skipping, already installed.'
fi


say "Installing and configuring Vim."
if [ ! -d "$HOME/.spf13-vim-3/" ]; then
    pip install --user isort jedi
    sudo apt-get -y install vim-nox
    vim  '+PlugInstall' '+qa!'
else
    say 'Skipping, already installed.'
fi

say 'Installing and configuring NeoVim.'
if ! which nvim; then
    sudo apt-get install -y python-dev python-pip  python3-pip xclip python-dev build-essential cmake
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install -y neovim
    pop install --user neovim
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
else
    say 'Skipping, already installed.'
fi


say "Installing and configuring Tmux."
if ! which tmux; then
    sudo apt-get install -y python-software-properties software-properties-common
    sudo add-apt-repository -y ppa:pi-rho/dev
    sudo apt-get update
    sudo at-get install -y tmux
else
    say 'Skipping, already installed.'
fi

say 'Colorizing StdErr in red.'
INSTALL_PATH="~/.local/stderred"
if [ ! -d "$INSTALL_PATH" ]; then
    sudo apt-get install -y build-essential cmake
    git clone git://github.com/sickill/stderred.git $INSTALL_PATH
    pushd $INSTALL_PATH
    make
    popd
else
    say 'Skipping, already installed.'
fi
exit 0
DATA:
begin 664 -
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
<^]P^M\_M<_O</K?/[7/[W-#S_P'4>1%L`!@!````
`
end
