if status is-interactive
    # Commands to run in interactive sessions can go here
end

# greeting
function fish_greeting -d "What's up, fish?"
    set_color $fish_color_autosuggestion
    uname -nmsr

    command -q uptime
    and command uptime

    set_color normal
end

# starship
starship init fish | source

# zoxide
zoxide init --cmd cd fish | source

# fzf

# aliases
alias m "make"
alias c "clear"
alias d "exit"
alias l "make lint"
alias r "make run"
alias pt "pytest"
alias gt "go tool"
alias vim nvim
alias ls eza
alias cat bat
alias grep rg
alias find fd
alias rm trash

function whoops
    git commit --amend --no-edit && git push --force-with-lease origin (git rev-parse --abbrev-ref HEAD)
end
export PATH="$PATH:$HOME/.local/bin"

# pnpm
set -gx PNPM_HOME "/Users/jay.bonthius/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

set -e AWS_PROFILE

set -gx PATH "/opt/homebrew/opt/openjdk/bin" $PATH

# Doom Emacs
set -gx PATH "$HOME/.config/emacs/bin" $PATH

# set -e GOROOT

# set -gx GOPATH "$HOME/go"
# set -gx PATH "$PATH:$GOPATH/bin"
# set -gx GOROOT "/opt/homebrew/Cellar/go/1.24.5/libexec"