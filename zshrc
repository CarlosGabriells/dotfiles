# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light jonmosco/kube-ps1
zinit light hlissner/zsh-autopair
zinit light zsh-users/zsh-history-substring-search
zinit light wfxr/forgit

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::docker-compose
zinit snippet OMZP::terraform

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Fzf-bat preview
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias cd="z"
alias cat="bat --paging never --style plain"
alias gauth="gcloud auth login"
alias code="code ."
alias lg="lazygit"
alias redis-cli="docker run --rm -it redis:alpine redis-cli"
alias myip='curl -s https://checkip.amazonaws.com'

# Kubernetes
alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias klog="kubectl logs"
alias ktop="kubectl top"
alias ksvc="kubectl get service"
alias kc="kubectx"
alias kn="kubens"
alias scan="kubescape scan"

# Infrastructure
alias tf="terraform"
alias tfa="terraform apply"
alias tfp="terraform plan"
alias tfi="terraform init"
alias h="helm"

# Docker  
alias d="docker"
alias dco="docker-compose"
alias dps="docker ps"
alias dim="docker images"

# Git
alias g="git"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gs="git status"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
source <(stern --completion=zsh)
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh




# macOS ARM Optimizations
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Export command
export PATH=/Users/carlosgabriel/.groundcover/bin:${PATH}
export PATH=$PATH:/Users/carlosgabriel/.kubescape/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export EDITOR=nvim

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/carlosgabriel/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
