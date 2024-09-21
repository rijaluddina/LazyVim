# Powerlevel10k Instant Prompt
# Ensures the Powerlevel10k prompt is loaded instantly, improving shell startup speed.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh Installation Path
# Defines the directory where Oh My Zsh is installed.
export ZSH="$HOME/.oh-my-zsh"

# Paths to Add
# Adds custom directories to the PATH environment variable for executable files.
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# GPG Configuration
# Ensures GPG prompts for passphrases work correctly in the terminal.
export GPG_TTY=$(tty)

# Oh My Zsh Theme
# Sets the theme for Oh My Zsh to Powerlevel10k.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
# Lists the plugins to be used with Oh My Zsh.
plugins=(
  git                     # Git plugin for git command enhancements.
  zsh-autosuggestions     # Provides suggestions based on command history.
  zsh-syntax-highlighting  # Highlights commands in the terminal for better readability.
  fast-syntax-highlighting # Fast syntax highlighting plugin.
  zsh-autocomplete        # Autocompletion for commands and options.
)

# Load Oh My Zsh
# Sources the Oh My Zsh script to enable its features and plugins.
source $ZSH/oh-my-zsh.sh

# Aliases
# Defines shortcuts for commonly used commands.
alias a="php artisan"    # Shortcut for Laravel Artisan commands.
alias g="lazygit"        # Shortcut for LazyGit.
alias n="npm"            # Shortcut for npm (Node.js package manager).
alias c="composer"       # Shortcut for Composer (PHP dependency manager).
alias L="laravel"        # Shortcut for Laravel commands.
alias cd="z"             # Shortcut for z command to navigate directories.
alias t="tmux"           # Shortcut for tmux (terminal multiplexer).
alias v="nvim"           # Shortcut for Neovim text editor.
alias ls="eza --icons=always"  # Shortcut for eza (better ls) with icons.

# Powerlevel10k Configuration
# Loads the Powerlevel10k configuration if it exists.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History Settings
# Configures how the command history is handled in zsh.
HISTFILE=$HOME/.zhistory       # File where history is saved.
HISTSIZE=1000                 # Number of commands to keep in memory.
SAVEHIST=1000                 # Number of commands to keep in the history file.
setopt BANG_HIST              # Special treatment for the '!' character.
setopt EXTENDED_HISTORY       # Write history in ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY     # Append to the history file immediately.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_IGNORE_DUPS       # Do not record duplicate commands.
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicates if a new entry is added.
setopt HIST_IGNORE_SPACE      # Ignore commands starting with a space.

# FZF (Fuzzy Finder) Configuration
# Sources the FZF configuration file if it exists.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# FZF Default Options
# Sets the default options for FZF to customize its appearance and behavior.
export FZF_DEFAULT_OPTS='
  --color=fg:#d0d0d0,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"
'

# FZF Commands
# Defines commands for FZF to find files and directories.
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# FZF Functions
# Defines custom functions for FZF to generate path and directory completions.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# FZF Git Integration
# Sources the FZF Git integration script for enhanced git operations with FZF.
source ~/.fzf-git.sh/fzf-git.sh
# Zoxide (Better cd) Configuration
eval "$(zoxide init zsh)"
# Eza (Better ls) Preview Configuration
# Configures previews for file and directory listings in FZF.
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
