export LC_CTYPE=en_US.UTF-8
export MANWIDTH=80

#
# Bash history
#
bind Space:magic-space  # auto-expand history magic
shopt -s histappend     # make sure hist is kept across sessions
export HISTCONTROL=erasedups
export HISTSIZE=5000
export PROMPT_COMMAND='history -a'  # Append immediately so new shells can use it

# for the love of god don't offer to autocomplete this shit
export FIGNORE="#:~:DS_Store:.pyc:.swp:.swo"

#
# I think I'm a convert.
#
export EDITOR=vim
export VISUAL=vim

# PATH Settings, clearly
# Don't need any additions at the moment
# [[ -r ~/.bash.d/paths.sh ]] && source ~/.bash.d/paths.sh

# Simple check for an interactive shell -- don't do anything else if not.
# So, make PATH additions and stuff before this.
[ -z "$PS1" ] && return

# 'cd' to children of a host of directories, as if they were always in CWD
export CDPATH=:~:~/src

# Directory listings in Technicolor
export CLICOLOR='true'
export LSCOLORS="gxfxcxdxbxegedabagacad"

#
# 'less' is more
#
export PAGER="/usr/bin/less"
export LESS="-Ri"
if command -v lesspipe.sh >/dev/null; then
    export LESSOPEN="|lesspipe.sh %s"
fi

# A man's prompt is his castle, or something.
[[ -r ~/.bash.d/prompt.sh ]] && source ~/.bash.d/prompt.sh

# Functions for great justice
[[ -r ~/.bash.d/functions.sh ]] && source ~/.bash.d/functions.sh

# And aliases for all mankind
[[ -r ~/.bash.d/aliases.sh ]] && source ~/.bash.d/aliases.sh

# Completion
[[ -r ~/.bash.d/completion.sh ]] && source ~/.bash.d/completion.sh

# ====================================================
# =         App- and Platform-specific Bits          =
# ====================================================

#
# Startup file for Python's interactive interpreter.
# Sets up history and completion
#
export PYTHONSTARTUP=$HOME/.pythonrc
# virtualenv & wrapper
export VIRTUALENV_USE_DISTRIBUTE=true
export WORKON_HOME=$HOME/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

# OCaml OPAM configuration
[[ -r ~/.opam/opam-init/init.sh ]] && source ~/.opam/opam-init/init.sh

# Ruby Version Switching
# brew install chruby ruby-install
# Well put: http://pbrisbin.com/posts/chruby
if [ -x /usr/local/opt/chruby ]; then
    source /usr/local/opt/chruby/share/chruby/chruby.sh
    source /usr/local/opt/chruby/share/chruby/auto.sh
fi

# AWS credential management and env vars that the Java API tools want
[[ -r ~/.aws/setup.sh ]] && source ~/.aws/setup.sh

# Travis gem
[[ -r ~/.travis/travis.sh ]] && source ~/.travis/travis.sh

#
# Memcached
#
export EVENT_NOKQUEUE=1

#
# Choose your flava
#
if [ "$(uname -s)" == "Darwin" ] && [ -f ~/.bash.d/platform-osx.sh ]; then
    . ~/.bash.d/platform-osx.sh
elif [ -f ~/.bash.d/platform-linux.sh ]; then
    . ~/.bash.d/platform-linux.sh
fi

# Machine-specific stuff, creds kept out of SCM, etc.
if [ -d ~/.local ]; then
    for f in ~/.local/*.sh; do
        . "$f"
    done
fi

