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
+>_X_?H3@@@!``0``
`
end
