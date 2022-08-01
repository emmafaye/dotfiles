# # vim-plug
# apk update && apk add --no-cache gcc build-essential ripgrep && apk upgrade # Needed for Lua configs and Telescope
# curl -fLo ${HOME_PATH}/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# nvim -es -u ${HOME_PATH}/.config/nvim/init.vim -i NONE -c "PlugInstall" -c "qa"

# Spacevim - Vim-like Terminal
# apk update && apk add --no-cache font-fira-code-nerd && apk upgrade
# mkdir -p ~/.local/share/fonts
# cd ~/.local/share/fonts && curl -fLo "Fura Mono Regular Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Regular/complete/Fura%20Mono%20Regular%20Nerd%20Font%20Complete.otf
# git clone -b v2.0.0 https://github.com/SpaceVim/SpaceVim.git ${HOME_PATH}/.SpaceVim
# ln -s ${HOME_PATH}/.SpaceVim ${HOME_PATH}/.vim
# ln -s ${HOME_PATH}/.SpaceVim ${HOME_PATH}/.config/nvim