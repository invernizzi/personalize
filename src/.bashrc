#-[ Environment ]-------------------------------------------------------------

export PATH="${HOME}/.local/bin":${PATH}

#------------------------------------------------------------------------------


#-[ Tweaks ]-------------------------------------------------------------------

## Bash Tweaks
shopt -s cdspell     # Autmatically correct spelling mistakes in 'cd' args
shopt -s cmdhist     # Save multiline commands as a single history entry
shopt -s dotglob     # Make * expand to dotfiles too
shopt -s histappend  # Append to history files, instead of rewriting it.

# Enable programmable completion
if [ -f /etc/bash_completion  ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#------------------------------------------------------------------------------


#-[ Aliases ]------------------------------------------------------------------

alias l="ls --ignore='*.pyc'"

#------------------------------------------------------------------------------


#-[ Looks ]--------------------------------------------------------------------

# Powerline
export TERM='xterm-256color'
export POWERLINE_ROOT="${HOME}/.local/lib/python2.7/site-packages/powerline"
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
export OVERRIDE='ext.shell.theme=default_leftonly'
. ${POWERLINE_ROOT}/bindings/bash/powerline.sh

STDERRED_PATH="${HOME}/.local/stderred/build/libstderred.so"

if [ -f "$STDERRED_PATH" ]; then
    export LD_PRELOAD="$STDERRED_PATH":$LD_PRELOAD
fi

#------------------------------------------------------------------------------


#-[ Misc ]---------------------------------------------------------------------

# Configure vertical mouse buttons
# Warning: it breaks ssh
# if which xinput; then
#     if [ ! -z "$DISPLAY" ]; then  # If X is running
#         xinput set-button-map "Kingsis Peripherals Evoluent VerticalMouse 4" 1 2 3 4 5 6 7 8 9 10 11 12 13 14
#     fi
# fi

#------------------------------------------------------------------------------

# if which setxkbmap; then
#     setxkbmap -layout us -option ctrl:nocaps
# fi

