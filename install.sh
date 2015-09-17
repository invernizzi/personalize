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
if [ ! -f "${HOME}.local/bin/powerline" ]; then
    sudo apt-get install -y python-pip git python-dev fontconfig
    pip install --user powerline-status
    pip3 install --user powerline-status
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


say 'Installing and configuring NeoVim.'
if ! which nvim; then
    sudo apt-get install -y python-dev python-pip  python3-pip xclip python-dev build-essential cmake silversearcher-ag
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install -y neovim curl
    pip install --user neovim
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    pip install --user isort jedi
    nvim  '+PlugInstall' '+qa!'
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

say "Installing and configuring Zsh."
if ! which tmux; then
    sudo apt-get install -y zsh
    chsh -s /bin/zsh
else
    say 'Skipping, already installed.'
fi

say 'Colorizing StdErr in red.'
INSTALL_PATH="${HOME}/.local/stderred"
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
?]:R>U;-Z5L_J63VK9_6LGM6S>C[_^?^L9DE_`&@!````
`
end
