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
2_5P_U\^_V//_`>56OQ8`&`$`
`
end
