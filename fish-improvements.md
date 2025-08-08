# Fish Shell Improvements

## New Tools to Install
- `bat` - syntax highlighting file viewer
- `fd` - fast file finder
- `gh` - GitHub CLI
- `yq` - YAML/JSON processor
- `mise` - development environment manager

## Replace Aliases with Abbreviations
```fish
# Remove current aliases, add these abbreviations:
abbr vim nvim
abbr ls eza
abbr cat bat
abbr grep rg
abbr find fd
abbr rm trash
```

## New Power Functions
```fish
abbr pfile "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
abbr tldrf "tldr --list | fzf --preview 'tldr {1} --color' --preview-window=right,70% | xargs tldr"
```

## Plugin Manager
- Install Fisher plugin manager
- Add plugins: `bass`, `fzf-fish`, `fifc`, `git-abbr`