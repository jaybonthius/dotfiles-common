# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Aliases
alias m='make'
alias c='clear'
alias d='exit'
alias l='make lint'
alias r='make run'
alias pt='pytest'

alias z='zellij --layout compact'
alias zf='zellij'

whoops() {
    local current_branch=$(git rev-parse --abbrev-ref HEAD)

    print "This command will:"
    print "  1. Amend the last commit without changing the commit message."
    print "  2. Force-push (with lease) the branch '$current_branch' to 'origin'."
    print "\n\033[1;31mWARNING:\033[0m This rewrites history on the remote repository!"
    print "Ensure you coordinate with collaborators if this is a shared branch."

    read "?Proceed? [y/N] " confirm

    # Check the user's input (case-insensitive check for 'y')
    # The [[ ... ]] is Zsh's extended test construct.
    # The '=~' operator performs pattern matching. '^[Yy]' matches 'Y' or 'y' at the beginning.
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        print "\nProceeding with amend and force-push..."
        git commit --amend --no-edit && git push --force-with-lease origin "$current_branch"
        if [[ $? -eq 0 ]]; then
             print "\n\033[0;32mOperation successful.\033[0m"
             return 0
        else
             print "\n\033[1;31mOperation failed.\033[0m Check git output above."
             return 1
        fi
    else
        print "\nOperation aborted by user."
        return 1
    fi
}

zdev() {
    # Check if argument is provided
    if [[ $# -eq 0 ]]; then
        echo "Usage: zdev <directory>"
        echo "Example: zdev ../../my_repo"
        return 1
    fi

    local target_dir="$1"
    
    # Convert to absolute path and check if directory exists
    local abs_path=$(realpath "$target_dir" 2>/dev/null)
    if [[ $? -ne 0 ]] || [[ ! -d "$abs_path" ]]; then
        echo "Error: Directory '$target_dir' does not exist"
        return 1
    fi

    # Extract directory name for session name
    local session_name=$(basename "$abs_path")
    
    # Change to the target directory
    cd "$abs_path"
    
    # Check if session already exists (only check running sessions, not exited ones)
    if zellij list-sessions 2>/dev/null | grep -v "(EXITED" | grep -q "^$session_name\s"; then
        echo "Attaching to existing session: $session_name"
        zellij attach "$session_name"
    else
        echo "Creating new session: $session_name"
        zellij --layout dev-layout attach -c "$session_name"
    fi
}

source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# "before any calls to compdef"
# actually i don't really like autocomplete... not sure though
# source ~/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH=$PATH:/home/ubuntu/.local/bin
export PATH=$PATH:/home/ubuntu/go/bin/
export PATH=$PATH:/usr/local/go/bin


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"

eval "$(starship init zsh)"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always --style=numbers --line-range=:500 {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

  # CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

  # Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

if [ -f ~/.pyenv_profile ]; then
  source ~/.pyenv_profile
fi

zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets' export PATH=$HOME/.npm-global/bin:$PATH
export PATH=$HOME/.npm-global/bin:$PATH
eval "$(tv init zsh)"
