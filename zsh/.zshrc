# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to 'random', it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME='robbyrussell' # default theme - we override this with Starship Prompt

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( 'robbyrussell' 'agnoster' )

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git forgit node emoji zsh-autosuggestions zsh-syntax-highlighting tldr)

source $ZSH/oh-my-zsh.sh
# source $HOME/.zsh-autocomplete.zsh


# Custom Keybindings
bindkey '   ' autosuggest-accept # Tab to accept autosuggestion

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias zshconfig='code ~/.zshrc'
alias ohmyzsh='code ~/.oh-my-zsh'

# Forgit Interactive Git Aliases
forgit_log=glo
forgit_diff=gd
forgit_add=ga
forgit_reset_head=grh
forgit_ignore=gi
forgit_checkout_file=gcf
forgit_checkout_branch=gcb
forgit_branch_delete=gbd
forgit_checkout_tag=gct
forgit_checkout_commit=gco
forgit_revert_commit=grc
forgit_clean=gclean
forgit_stash_show=gss
forgit_cherry_pick=gcp
forgit_rebase=grb
forgit_blame=gbl
forgit_fixup=gfu

# Git Aliases
alias g='git'
alias gau='git ls-files -o --exclude-standard -z | xargs -0 git add' # Add all untracked files to git
alias gb='git branch'
alias gc='git commit'
alias gca='git commit --amend'
alias gcam='git commit --amend --c' # Amend commit message
alias gcm='git commit -m' # Commit with message
alias gs='git status'
alias grmd='git ls-files --deleted -z | xargs -0 git rm' # Remove deleted files from git
alias gp='git pull'
alias gpo='git pull origin main'
alias gpom='git pull origin main'
alias gpho='git push origin'
alias gphom='git push origin main'
alias gsw'git show -w --color-words --oneline'
alias gswn='git show -w --name-only --color-words --oneline'
alias gl='git log --all --decorate --graph --date=relative --pretty=format:"%C(auto,yellow)%h%C(auto,magenta)% G? %C(auto,blue)%>(12,trunc)%ad %C(auto,green)%<(10,trunc)%aN%C(auto,reset)%s%C(auto,red)% gD% D"'
alias glom='git fetch origin; gl origin/main --author="<$(git config user.email)>"'
# alias ga='git add'
# alias gbd='git branch -D' # Delete branch
# alias gco=git checkout main # Checkout branch main
# alias gco=git_checkout_fallback # Checkout branch main or master

# Custom functions
alias ls='exa -lah -s type --time-style=iso --icons --git'
alias find='fd'
alias cat='bat --paging=never'
alias cls='clear' # Clear screen
alias n='cls; node'
alias serve='python -m SimpleHTTPServer'
alias node_serve='npm install http-server -g && http-server'
alias reload='cls; source ~/.zshrc'
alias wn='set_win_title'
alias vim='nvim'
alias vimdiff='nvim -d'

# Directory Shortcuts
alias app='/usr/src/app'
alias home='~/'
alias npm_modules='/usr/local/lib/node_modules'
alias zsh_custom='/root/.oh-my-zsh/custom'

# Ignore dollar sign from beginning of lines
alias '$'='echo "$COLOR_YELLOW $COLOR_GRAY Whoops! Looks like you have a rogue \"$\", ignoring that...$COLOR_NC";'


# Colors Variables
COLOR_NC='\e[0m' # No Color
COLOR_BLACK='\e[0;30m'
COLOR_GRAY='\e[1;30m'
COLOR_RED='\e[0;31m'
COLOR_LIGHT_RED='\e[1;31m'
COLOR_GREEN='\e[0;32m'
COLOR_LIGHT_GREEN='\e[1;32m'
COLOR_BROWN='\e[0;33m'
COLOR_YELLOW='\e[1;33m'
COLOR_BLUE='\e[0;34m'
COLOR_LIGHT_BLUE='\e[1;34m'
COLOR_PURPLE='\e[0;35m'
COLOR_LIGHT_PURPLE='\e[1;35m'
COLOR_CYAN='\e[0;36m'
COLOR_LIGHT_CYAN='\e[1;36m'
COLOR_LIGHT_GRAY='\e[0;37m'
COLOR_WHITE='\e[1;37m'


# Custom Functions
function chpwd() {
    emulate -L zsh
    exa -1ah -s type --icons --git
}

function force_update_branch() {
    git fetch origin
    git checkout origin/$1
    git branch -D $1
    git checkout -b $1
}

function git_checkout_tag() {
    git checkout tags/$1 -b $1
}

# git checkout master 1> /dev/null || { echo 'Main unavailable, trying master'; git checkout master; return 1 }
# git checkout master 2> /dev/null ||  [ $? -eq 141 ] || { echo 'Master unavailable, trying main'; git checkout main; return 1 }
function git_checkout_fallback() {
  git checkout master 2>/dev/null || \
  [ $? -eq 141 ] || \
  git checkout foo
}

# Set Window Title
function set_win_title() {
    echo -ne "\033]0; $(basename "$PWD") \007"
}
starship_precmd_user_func='set_win_title'

# Starship Prompt
eval "$(starship init zsh)"


# SSH Handling
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#     export EDITOR='vim'
# else
#     export EDITOR='mvim'
# fi

if [ -z "$SSH_AUTH_SOCK" ]; then
    # Check for a currently running instance of the agent
    RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
    if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> $HOME/.ssh/ssh-agent
    fi
    eval `cat $HOME/.ssh/ssh-agent`
fi


# ZSH Generic Configuration

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE='true'

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE='true'

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE='true'

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT='true'

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS='true'

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE='true'

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION='true'

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS='true'

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY='true'

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# 'mm/dd/yyyy'|'dd.mm.yyyy'|'yyyy-mm-dd'
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS='mm/dd/yyyy'