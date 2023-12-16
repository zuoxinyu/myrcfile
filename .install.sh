#!bash

# AUR
sudo echo '[archlinuxcn]' >> /etc/pacman.conf
sudo echo '' >> /etc/pacman.conf
sudo echo 'SigLevel = Optional TrustAll'
sudo echo '' >> /etc/pacman.conf
sudo echo 'Server = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf
sudo pacman -Sy --needed archlinuxcn-keyring

# arch packages
sudo pacman -S --needed openssh zsh starship vim neovim-git git tig neomutt tmux ripgrep most bat htop ranger fd fzf lsd exa pass neofetch tealdeer translate-shell bc
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# syntax highlight
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# power10k
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# install tpm
git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# nvim coc settings
ln -sf $HOME/.vim/coc-settings.json .config/nvim/coc-settings.json

# dev envs
sudo pacman -S --needed gcc clang rustup nodejs yarn python python-pip
sudo pacman -S --needed vscode-json-languageserver vscode-html-languageserver vscode-css-languageserver vscode-markdown-languageserver lua-language-server

# vcpkg
git clone https://github.com/Microsoft/vcpkg.git $HOME/.vcpkg

# xmake

# gui

source $HOME/.zshrc
