#!/bin/sh

#sudo mkdir -p /usr/include/python2.7
#sudo ln -s /System/Library/Frameworks/Python.framework/Versions/Current/include/python2.7/pyconfig.h /usr/include/python2.7/pyconfig.h

ln -s ~/.vim/vimrc ~/.vimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo vim +PluginInstall +qall
