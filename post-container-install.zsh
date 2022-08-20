#!/bin/zsh

# SSH, GPG Keys & GitHub CLI
apk update && apk add --no-cache openssh openssh-keygen github-cli gnupg && apk upgrade

# ZSH Plugins
git clone https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
git clone https://github.com/wfxr/forgit.git ${ZSH_CUSTOM}/plugins/forgit

# Starship - Cross-shell Command Prompt
apk update && apk add --no-cache starship && apk upgrade

# NeoVim
apk update && apk add --no-cache neovim && apk upgrade
# Install NvChad - Fast neovim config with solid defaults and UI
apk update && apk add --no-cache alpine-sdk ripgrep && apk upgrade # Needed for Lua configs and Telescope
# apk update && apk add --no-cache gcc build-essential ripgrep && apk upgrade # Needed for Lua configs and Telescope
git clone https://github.com/NvChad/NvChad ${HOME_PATH}/.config/nvim --depth 1
mkdir -p ${NVIM_PATH}/lua/custom
cp ${WORK_PATH}/.devcontainer/nvim/init.lua ${WORK_PATH}/.devcontainer/nvim/chadrc.lua ${NVIM_PATH}/lua/custom/
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
# TODO: Figure out why it doesn't work after first run and configure plugins correctly

# fzf - Command-line fuzzy finder
apk update && apk add --no-cache fzf && apk upgrade

# fd - alternative to find with built-in gitignore support
apk update && apk add --no-cache fd && apk upgrade

# Count Lines of Code
apk update && apk add --no-cache cloc && apk upgrade

# bat - cat clone with syntax highlighting and Git integration
apk update && apk add --no-cache bat && apk upgrade

# exa - ls replacement with colors and icons
apk update && apk add --no-cache exa && apk upgrade
# Fix missing timezone in /etc/localtime from exa
apk update && apk add --no-cache tzdata && apk upgrade
ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# TLS/SSL Toolchain
apk update && apk add --no-cache openssl grep && apk upgrade

# # Linter and Formatter
# npm install -g @trunkio/launcher

# tldr - a command-line manpage viewer
npm install -g tldr
mkdir -p ${ZSH_CUSTOM}/plugins/tldr
ln -s ${NPM_PATH}/tldr/bin/completion/zsh/_tldr ${ZSH_CUSTOM}/plugins/tldr/_tldr

# Update tldr quitely
(pkill -f 'tldr'; &>/dev/null tldr --update &)