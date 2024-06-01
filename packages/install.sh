#!/bin/bash
sudo apt update && sudo apt upgrade

sudo apt install -y parallel make gh build-essential i3 \
	stow xsel tmux tmuxp zsh openssl fzf picom \
	zathura unzip mpv vlc pulsemixer playerctl qbittorrent \
	pass unrar vim nautilus jq htop podman feh rofi \
	libbz2-dev libreadline-dev libssl-dev \
	liblzma-dev libsqlite3-dev tk-dev \
	apt-transport-https ca-certificates gnupg

if ! command -v cargo &>/dev/null; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

	cargo install eza
	cargo install fd-find
	cargo install tree-sitter-cli
	cargo install ripgrep
	cargo install bat
else
	echo "rust installed"

	cargo install eza
	cargo install fd-find
	cargo install tree-sitter-cli
	cargo install ripgrep
	cargo install bat
fi

if ! command -v lazygit &>/dev/null; then
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
else
	echo "lazygit installed"
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
	echo "tpm installed"
fi

if [ ! -f "$NVM_DIR/nvm.sh" ]; then
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	nvm install stable
	nvm use stable
else
	echo "nvm installed"
fi

if [ ! -d "$PYENV_ROOT" ]; then
	curl https://pyenv.run | bash
else
	echo "pyenv installed"
fi

if ! command -v nvim &>/dev/null; then
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	./nvim.appimage --appimage-extract
	./squashfs-root/AppRun --version
	sudo mv squashfs-root /
	sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
	npm install -g neovim
else
	echo "nvim installed"
fi

if ! command -v nix &>/dev/null; then
	sh <(curl -L https://nixos.org/nix/install) --daemon
else
	echo "nix istalled"
fi

if ! command -v direnv &>/dev/null; then
	curl -sfL https://direnv.net/install.sh | bash
else
	echo "direnv istalled"
fi
