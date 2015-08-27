#-[ Environment ]-------------------------------------------------------------

export PATH="${HOME}/.local/bin":"${HOME}/bin":${PATH}
export EDITOR=vim
export VISUAL=vim
export BROWSER=google-chrome

#------------------------------------------------------------------------------


#-[ Tweaks ]-------------------------------------------------------------------

## Bash Tweaks
shopt -s cdspell                 # Autmatically correct spelling mistakes in 'cd' args
shopt -s dotglob                 # Make * expand to dotfiles too
shopt -s checkwinsize            # Bash reloads window size upon resizing
shopt -s hostcomplete            # Hostname completion after @
shopt -s no_empty_cmd_completion

## history
shopt -s cmdhist                 # Save multiline commands as a single history entry
shopt -s histappend              # Append to history files, instead of rewriting it.
export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTIGNORE="&:ls:[bf]g:exit" # Don't save in history duplicates(&), and not interesting commands

# Enable programmable completion
if [ -f /etc/bash_completion  ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

set -o vi                           # Vi mode (instead of Emacs)

## Less tweaks
export LESS="-R"                    # Less interprets bash colours
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)" # Make less more friendly for non-text input files

# LS COLORS
eval "`dircolors -b`"
alias ls='ls --color=auto'

# MAN COLORS
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

# GREP COLORS
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

#------------------------------------------------------------------------------


#-[ Aliases ]------------------------------------------------------------------

alias l="ls --ignore='*.pyc'"
alias m='make'
alias v='vim'
alias vim-latex='vim.gnome --servername LATEX '
alias o='xdg-open'
alias rsync='rsync -P'

if [ -x "`which trash-put 2>/dev/null`" ]; then
	alias rm='trash-put'
else
	alias rm='rm -i '
fi
alias alert="notify-send -i gnome-terminal   --hint int:transient:1 'CLI' "  # Use as: job && alert "job finished" (|| alert "job failed!")
#------------------------------------------------------------------------------


#-[ Looks ]--------------------------------------------------------------------

# Powerline
export TERM='xterm-256color'
export POWERLINE_ROOT="${HOME}/.local/lib/python2.7/site-packages/powerline"
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
export POWERLINE_CONFIG_OVERRIDES='ext.shell.theme=default_leftonly'
POWERLINE_BASH_CONFIG='[
  {
    "function": "powerline.segments.common.time.fuzzy_time",
    "priority": 10
  },
  {
    "function": "powerline.segments.common.sys.cpu_load_percent",
    "priority": 50
  },
  {
    "function": "powerline.segments.common.net.hostname",
    "priority": 100
  },
  {
    "function": "powerline.segments.common.env.user",
    "hide_user": "invernizzi",
    "priority": 200
  },
  {
    "function": "powerline.segments.common.vcs.branch",
    "status_colors": true,
    "priority": 30
  },
  {
    "function": "powerline.segments.common.env.virtualenv",
    "priority": 50
  },
  {
    "function": "powerline.segments.shell.cwd",
    "priority": 40
  },
  {
    "function": "powerline.segments.shell.jobnum",
    "priority": 20
  },
  {
    "function": "powerline.segments.shell.last_status",
    "priority": 10
  }
]'
export POWERLINE_THEME_OVERRIDES="default_leftonly.segments.left=${POWERLINE_BASH_CONFIG//[[:space:]]/}"
. ${POWERLINE_ROOT}/bindings/bash/powerline.sh

powerline_path=$(python -c 'import pkgutil; print pkgutil.get_loader("powerline").filename' 2>/dev/null)
if [[ "$powerline_path" != "" ]]; then
  . ${POWERLINE_ROOT}/bindings/bash/powerline.sh
else
  # Normal PS1
  echo 'No powerline found.'
fi

# Stderred
STDERRED_PATH="${HOME}/.local/stderred/build/libstderred.so"

if [ -f "$STDERRED_PATH" ]; then
    export LD_PRELOAD="$STDERRED_PATH":$LD_PRELOAD
fi

#------------------------------------------------------------------------------


#-[ Misc ]---------------------------------------------------------------------

# Virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
source ~/.local/bin/virtualenvwrapper.sh

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

# xmodmap ~/.bash/Xmodmap 2>/dev/null

#-[ Autocompletion ]-----------------------------------------------------------
_tmuxinator() {
    COMPREPLY=()
    local word="${COMP_WORDS[COMP_CWORD]}"

    if [ "$COMP_CWORD" -eq 1 ]; then
        local commands="$(compgen -W "$(tmuxinator commands)" -- "$word")"
        local projects="$(compgen -W "$(tmuxinator completions start)" -- "$word")"

        COMPREPLY=( $commands $projects )
    else
        local words=("${COMP_WORDS[@]}")
        unset words[0]
        unset words[$COMP_CWORD]
        local completions=$(tmuxinator completions "${words[@]}")
        COMPREPLY=( $(compgen -W "$completions" -- "$word") )
    fi
}

complete -F _tmuxinator tmuxinator mux

_paver()
{
    local cur
    COMPREPLY=()
    # Variable to hold the current word
    cur="${COMP_WORDS[COMP_CWORD]}"

    # Build a list of the available tasks from: `paver --help --quiet`
    local cmds=$(paver -hq | awk '/^  ([a-zA-Z][a-zA-Z0-9_]+)/ {print $1}')

    # Generate possible matches and store them in the
    # array variable COMPREPLY
    COMPREPLY=($(compgen -W "${cmds}" $cur))
}

# Assign the auto-completion function for our command.
complete -F _paver paver
