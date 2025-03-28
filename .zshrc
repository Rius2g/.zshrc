# === ENV ===
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# === Theme ===
ZSH_THEME="cloud"

# === Plugins ===
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
)

source $ZSH/oh-my-zsh.sh

# === History settings ===
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# === Dev Aliases ===
#
# === eza Aliases ===
alias ll="ls -lah --git"
alias lt="eza --tree"
alias lsg="eza --lah --git --git-ignore"
alias ls="eza"

#=== Git Aliases ===
alias gs="git status"
alias gc="git commit -m"
alias gp="git push"
alias ghco="gh pr checkout"
alias ghpv="gh pr view --web"
alias ghci="gh issue create"
alias ghprc="gh pr create --web"


# === PNPM Aliases ===
alias npm="pnpm"
alias pi="pnpm install"
alias pr="pnpm run"
alias pdev="pnpm run dev"
alias pu="pnpm update"

#=== Misc Aliases ===
alias cleanup="brew cleanup && brew autoremove"
alias ports="lsof -i -P | grep LISTEN"
alias ..="cd .."
alias ...="cd ../.."
alias cd="z"
alias reload="source ~/.zshrc && echo '🔄 Reloaded .zshrc'"
alias copy="pbcopy"
alias paste="pbpaste"
alias e="z ~/eevy"



alias v="nvim"

alias zhelp="__zsh_aliases_fzf"

function __zsh_aliases_fzf() {
  local aliases=(
    "🔄 reload::Reload .zshrc"
    "🗂 ..::cd .."
    "🗂 ...::cd ../.."
    "🗂 ports::lsof -i -P | grep LISTEN"
    "🌳 ll::eza -lah --git"
    "🌳 ls::eza"
    "🌳 lt::eza --tree"
    "🌳 lsg::eza --lah --git --git-ignore"
    "🧹 cleanup::brew cleanup && brew autoremove"
    "🐙 gs::git status"
    "🐙 gc \"msg\"::git commit -m \"msg\""
    "🐙 gp::git push"
    "🐙 ghco::gh pr checkout"
    "🐙 ghpv::gh pr view --web"
    "🐙 ghci::gh issue create"
    "🐙 ghprc::gh pr create --web"
    "⚡ npm::pnpm"
    "⚡ pi::pnpm install"
    "⚡ pr::pnpm run"
    "⚡ pdev::pnpm run dev"
    "⚡ pu::pnpm update"
    "💻 v::nvim"
    "❓ zhelp::Show this help menu"
  )

  local selected=$(printf "%s\n" "${aliases[@]}" | \
    awk -F "::" '{ printf "%-14s ➜ %s\n", $1, $2 }' | \
    fzf \
      --reverse \
      --height=50% \
      --border=rounded \
      --prompt="☠  2G Terminal › " \
      --color="fg:#f8f8f2,bg:#1b1d1e,hl:#ff5555,fg+:#f8f8f2,bg+:#1b1d1e,hl+:#ff5555,info:#8be9fd,prompt:#ff5555,pointer:#ff5555,marker:#ff5555,spinner:#ff5555,header:#bd93f9" \
      --header="💡 Select an alias to copy to clipboard"
  )

  if [[ -n "$selected" ]]; then
    echo "$selected" | awk '{ print $2 }' | pbcopy
    echo "☠ Copied '$selected' to clipboard!"
  fi
}



# === Command Timing (only show if >2 sec) ===
REPORTTIME=2

# === Prettier man pages ===
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'


eval "$(zoxide init zsh)"
eval "$(thefuck --alias)"

# Dashboard on terminal start
function show_dashboard() {
  clear

  # Optional banner
  if command -v figlet &> /dev/null && command -v lolcat &> /dev/null; then
    figlet "Nah, I'd win" | lolcat
    echo "Welcome back, $USER@$(hostname)" | lolcat
  else
    echo "🧠  Welcome, $USER"
  fi

  echo ""
  echo "🚀  Quick Commands:"
  echo "  🧠  Neovim:         v"
  echo "  ⚙️   Config:         reload"
  echo "  🧼  Clean system:   cleanup"
  echo "  🦾  Git status:     gs"
  echo "  📂  File manager:   lf"
  echo ""

  # Git info
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "🔀  Git Branch:      $(git rev-parse --abbrev-ref HEAD)"
    echo "📦  Changes:         $(git status --short | wc -l | tr -d ' ') files"
  fi


  echo ""
}

show_dashboard

