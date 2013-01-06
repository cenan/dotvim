Installation:

	git clone git://github.com/cenan/dotvim.git ~/.vim

Create symlinks:

	ln -s ~/.vim/vimrc ~/.vimrc

Switch to the `~/.vim` directory, and fetch submodules:

	cd ~/.vim
	git submodule update --init

Updating single plugin:

	cd ~/.vim/bundle/foo
	git pull origin master

Updating all plugins:

	cd ~/.vim
	git submodule foreach git pull origin master

Adding a new plugin:

	cd ~/.vim
	git submodule add git://github.com/foo/bar.git bundle/bar.vim


