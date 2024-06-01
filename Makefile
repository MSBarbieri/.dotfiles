install:
	bash ./packages/install.sh
	stow -vt ~ stow

update:
	bash ./packages/install.sh
	stow --adopt -vt ~ stow
