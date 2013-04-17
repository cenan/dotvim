# Installation

	git clone git://github.com/cenan/dotvim.git ~/.vim

Create symlinks:

	ln -s ~/.vim/vimrc ~/.vimrc

Switch to the `~/.vim` directory, and fetch submodules:

	cd ~/.vim
	git submodule update --init

# Plugins

## Updating single plugin

	cd ~/.vim/bundle/foo
	git pull origin master

## Updating all plugins

	cd ~/.vim
	git submodule foreach git pull origin master

After pulling changes from another terminal, `git submodule update` would sync `.gitmodules` with `bundles` directory.

## Adding a new plugin

	cd ~/.vim
	git submodule add git://github.com/foo/bar.git bundle/bar.vim

## Removing a plugin

* Delete the relevant section from the `.gitmodules` file.
* Delete the relevant section from `.git/config`
* Run `git rm --cached path_to_submodule` (no trailing slash).
* Commit
* `rm -rf path_to_submodule`
