#!/bin/sh

ln -s ~/.vim/vimrc ~/.vimrc
git submodule update --init
cd bundle/pyflakes-vim
git submodule update --init
