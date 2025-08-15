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

# PATH
set -gx PATH $PATH $HOME/.local/bin

# starship
starship init fish | source

# zoxide
zoxide init --cmd cd fish | source

# fzf
set fzf_preview_dir_cmd eza --all --color=always
fzf_configure_bindings --history=\cr --directory=\cf --git_log=\cg --git_status=\cs --processes=\cp
set fzf_preview_file_cmd cat -n

# aliases
alias m make
alias c clear
alias d exit
alias lg lazygit
alias l "make lint"
alias r "make run"
alias pt pytest
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

# set -e AWS_PROFILE

# set -gx PATH "/opt/homebrew/opt/openjdk/bin" $PATH

# set -e GOROOT
# set -gx GOPATH "$HOME/go"
# set -gx PATH "$PATH:$GOPATH/bin"
# set -gx GOROOT "/opt/homebrew/Cellar/go/1.24.5/libexec"
