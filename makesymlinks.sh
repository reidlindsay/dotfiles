#!/bin/bash
# This script creates symlinks from the home directory to all dotfiles in ~/dotfiles

DIR=~/dotfiles
FILES=".vimrc .vim .pythonrc.py"

echo -n "Changing to $DIR directory..."
cd $DIR
echo "done"

for file in $FILES; do
    echo "Remove ~/$file"
    rm -frd ~/$file
    echo "Creating symlink to $DIR/$file in ~/$file"
    ln -s $DIR/$file ~/$file
done
