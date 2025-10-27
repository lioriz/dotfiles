# dotfiles

Personal shell configuration files with custom themes and enhanced productivity features.

## Contents

- **`.bashrc`** - Bash shell configuration with custom prompt theme
- **`.zshrc`** - Zsh shell configuration with equivalent functionality

## Features

### Custom Shell Prompts
Both configurations feature elegant, informative prompts inspired by the oh-my-zsh robbyrussell theme:

- **User segment**: Shows username (or `$GITHUB_USER` if set) in green
- **Status indicator**: Arrow (➜) that turns red on command failure
- **Directory path**: Current working directory in blue, truncated to 4 levels
- **Git integration**: Branch name in red with optional dirty status indicator
- **Terminal title**: Dynamic window titles showing current command or shell

### Git Integration
- Displays current branch or commit hash in the prompt
- Optional dirty status indicator (✗) when files are modified
- Respects devcontainers and codespaces theme configuration:
  - `git config devcontainers-theme.hide-status 1` - Hide git status
  - `git config codespaces-theme.hide-status 1` - Hide git status  
  - `git config devcontainers-theme.show-dirty 1` - Show dirty status

### Enhanced History
- **Bash**: `ignoreboth` (ignores duplicates and lines starting with space)
- **Zsh**: Advanced options including `SHARE_HISTORY`, `APPEND_HISTORY`, and duplicate handling
- Increased history size (1000 commands, 2000 lines saved)

### Useful Aliases
```bash
ll='ls -alF'        # Detailed list with indicators
la='ls -A'          # List all except . and ..
l='ls -CF'          # Compact list with indicators
grep='grep --color=auto'  # Colored grep output
```

### Color Support
- Automatic color detection for terminals
- Colored `ls`, `grep`, `fgrep`, and `egrep` output
- Respects `~/.dircolors` if present

## Installation

### Quick Setup
```bash
# Clone this repository
git clone <repository-url> ~/dotfiles

# Backup existing configs (optional)
cp ~/.bashrc ~/.bashrc.backup
cp ~/.zshrc ~/.zshrc.backup

# Install configurations
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc

# Reload your shell
source ~/.bashrc  # for bash
source ~/.zshrc   # for zsh
```

### Manual Installation
You can also copy the contents of either file directly into your existing shell configuration.

## Customization

### GitHub User Integration
Set your GitHub username to display it instead of your system username:
```bash
export GITHUB_USER="your-github-username"
```

### Git Status Configuration
Control git prompt behavior in different environments:
```bash
# Hide git status completely
git config --global devcontainers-theme.hide-status 1

# Show dirty status indicator
git config --global devcontainers-theme.show-dirty 1
```

### FZF Integration
The bash configuration includes optional fzf integration. Install fzf and it will be automatically sourced.

## Compatibility

- **Bash**: Tested with bash 4.0+
- **Zsh**: Uses native zsh features, compatible with zsh 5.0+
- **Terminals**: Works with xterm, iTerm2, Terminal.app, and most modern terminals
- **Systems**: Linux, macOS, WSL

## Additional Files

Both configurations support optional additional files:
- `~/.bash_aliases` or `~/.zsh_aliases` - Custom aliases
- `~/.dircolors` - Custom color schemes for ls
- `~/.fzf.bash` - FZF fuzzy finder integration (bash)