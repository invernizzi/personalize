ANTIGEN_PATH="${HOME}/.antigen.zsh"

# If antigen is not installed, do it
if [ ! -f "$ANTIGEN_PATH" ]; then
  wget https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh -O "$ANTIGEN_PATH"
fi

# Load antigen
source "$ANTIGEN_PATH"

# Plugins
# antigen use oh-my-zsh                            # Load the oh-my-zsh's library.
antigen bundle git
antigen bundle pip
antigen bundle python
antigen bundle virtualenv
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting # Syntax highlighting bundle.
antigen bundle zsh-users/zsh-history-substring-search # Search with up arrow
antigen bundle djui/alias-tips                   # If you have an alias for it, dispplay it.
antigen bundle tmuxinator
antigen bundle vagrant
antigen bundle ssh-agent                         # Start ssh agent, if needed

# Theme
POWERLEVEL9K_MODE='awesome-patched'
DEFAULT_USER='invernizzi'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs virtualenv status)
antigen theme bhilburn/powerlevel9k powerlevel9k

# Apply everything!
antigen apply


# History
SAVEHIST=10000
HISTFILE=~/.zsh_history
