#!/usr/bin/bash

# Installed oh my zsh
/usr/bin/apt-get install -y curl && sh -c "$(curl -fsSL <https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh>)" || echo "Package Installed Error" && exit 1

# Auto Suggestion Installed
/usr/bin/git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Syntax Highlighting Installed
/usr/bin/git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Copy .zshrc
/usr/bin/cp -R .zshrc ~/

source ~/.zshrc && exit
