.PHONY: install

install:
	bash ./packages/install.sh
	@cd stow && ./install
