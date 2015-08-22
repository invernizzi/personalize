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
.F^??X/G_%8>@CP`8`0``
`
end
