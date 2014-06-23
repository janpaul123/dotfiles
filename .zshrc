# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jp"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

REPORTTIME=5

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby gem rails sublime rbenv coffee node npm nvm redis-cli brew history github heroku osx bundler)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/Users/jp/.rbenv/shims:/Users/jp/.nvm/v0.10.5/bin:/usr/local/share/npm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/texbin

# Other stuff

export NODE_PATH="/usr/local/lib/node_modules"

export PATH="/usr/local/share/npm/bin:$PATH"

export JENKINS_USER="janpaul123"

export EDITOR="subl -n -w"

ulimit -n 10000

export WORKON_HOME=/src/virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
[[ -s /Users/jp/.nvm/nvm.sh ]] && . /Users/jp/.nvm/nvm.sh # This loads NVM

eval "$(rbenv init -)"

alias gu="git up"
alias gx="gitx"
alias gcb="git checkout -b"
alias gpu="git push -u origin HEAD"

# added by travis gem
[ -f /Users/jp/.travis/travis.sh ] && source /Users/jp/.travis/travis.sh
