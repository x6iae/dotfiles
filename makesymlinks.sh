#!/bin/bash
############################
# .make.sh
# Gotten from https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh,
# THANKS TO Michael J. Smalley
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc zshrc rvmrc gemrc gitignore_global gitconfig gitconfig-transfix"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
[ -d $olddir ] && rm -rf $olddir
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

install_vundle() {
    # Test to see if vundle is un-available and install
    if [[ ! -d ~/.vim/bundle/ ]]; then
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
    vim +PluginInstall +qall
}

# work in progress, switching from vundle to vim-plug:
# https://github.com/junegunn/vim-plug
# install_vimPlug() {
#   data_dir=has('nvim') ? stdpath('data') . '/site' : '~/.vim'
#   if [ empty(glob(data_dir . '/autoload/plug.vim')) ]
#     silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
#     autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
#   fi
# }

# add sublime to command to terminal
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

install_vundle
