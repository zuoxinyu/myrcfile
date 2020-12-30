#!bash

# arch packages
sudo pacman -S zsh vim git tig neomutt tmux ripgrep most bat htop ranger fzf lsd
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# syntax highlight
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# power10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# install tpm
git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# nvim coc settings
ln -sf $HOME/.vim/coc-settings.json .config/nvim/coc-settings.json
