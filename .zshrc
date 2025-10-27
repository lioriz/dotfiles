# ~/.zshrc — zsh version of your bashrc theme

# Only for interactive shells
[[ $- != *i* ]] && return

##### History (zsh-ish equivalents)
HISTFILE=${HISTFILE:-~/.zsh_history}
HISTSIZE=1000
SAVEHIST=2000
setopt APPEND_HISTORY       # append rather than overwrite
setopt SHARE_HISTORY        # share across sessions
setopt HIST_IGNORE_SPACE    # lines starting with space not saved
setopt HIST_IGNORE_DUPS     # ignore duplicate consecutive commands
setopt INC_APPEND_HISTORY   # write immediately, incrementally

##### Colors & completion
autoload -Uz colors; colors
autoload -Uz compinit; compinit

##### Aliases (same as your bashrc)
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# If you keep a separate aliases file:
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

##### Prompt logic (zsh-native)
setopt prompt_subst   # allow $(...) in PROMPT

# Arrow turns red on error; name comes from $GITHUB_USER if set
user_segment() {
  local name="${GITHUB_USER:-$USER}"
  local arrow="%F{reset}➜%f"
  if [[ $? -ne 0 ]]; then
    arrow="%F{red}➜%f"
  fi
  print -n "%F{green}$name%f $arrow"
}

# Git branch segment, with same git-config toggles as your bash file
git_segment() {
  # Respect devcontainers/codespaces hide flag
  local hide1 hide2
  hide1=$(git config --get devcontainers-theme.hide-status 2>/dev/null)
  hide2=$(git config --get codespaces-theme.hide-status 2>/dev/null)
  [[ "$hide1" == "1" || "$hide2" == "1" ]] && return 0

  # Find branch (or short hash)
  local branch
  branch=$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
        || git --no-optional-locks rev-parse --short HEAD 2>/dev/null) || return 0
  [[ -z "$branch" ]] && return 0

  # Optional dirty marker
  local dirty=""
  if [[ "$(git config --get devcontainers-theme.show-dirty 2>/dev/null)" == "1" ]]; then
    if git --no-optional-locks ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" >/dev/null 2>&1; then
      dirty=" %F{yellow}✗%f"
    fi
  fi

  print -n " %F{cyan}(%F{red}${branch}%f%F{cyan})%f${dirty} "
}

# Assemble the prompt: green user, arrow, blue cwd, cyan (red branch), $
PROMPT='$(user_segment) %F{blue}%4~%f $(git_segment)%f$ '

# Similar to your bash “title” logic (works for xterm, iTerm, etc.)
preexec() { print -Pn "\e]0;%n@%m: $1\a" }
precmd()  { print -Pn "\e]0;%n@%m: ${SHELL}\a" }

##### Misc parity with your bashrc
# Make less friendlier if available (optional)
if command -v lesspipe >/dev/null 2>&1; then
  eval "$(SHELL=/bin/sh lesspipe)"
fi

# grep/egrep/fgrep color (zsh usually inherits from env; keep if desired)
if command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Bash completion equivalent isn’t needed; zsh has native compinit (enabled above)

# Optional: source ~/.zprofile / ~/.zlogin as you like (not needed for this prompt)
