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
$`$`!````
`
end
