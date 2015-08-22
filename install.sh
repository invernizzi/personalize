#!/bin/bash

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
    pip3 install --user powerline-status
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
    pip install --user virtualenvwrapper
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
# qpdfview latexmk xdotool


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
!````
`
end
