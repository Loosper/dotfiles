mkdir -p ~/.vim/colors
mkdir -p ~/.config/htop
mkdir -p ~/system

ln -s `pwd`/.gdbinit ~/.gdbinit
ln -s `pwd`/.gitconfig ~/.gitconfig
ln -s `pwd`/.pythonrc ~/.pythonrc
ln -s `pwd`/.tmux.conf ~/.tmux.conf
ln -s `pwd`/.vimrc ~/.vimrc
ln -s `pwd`/.zshrc ~/.zshrc
ln -s `pwd`/.zsh_system_source ~/system/.zsh_system_source
ln -s `pwd`/ssh/config ~/.ssh/config
ln -s `pwd`/ssh/rc ~/.ssh/rc
ln -s `pwd`/.gitignore ~/.gitignore
ln -s `pwd`/badwolf.vim ~/.vim/colors/badwolf.vim
ln -s `pwd`/htoprc ~/.config/htop/htoprc
ln -s `pwd`/.ctags.d ~/.ctags.d

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp mine.zsh-theme ~/.oh-my-zsh/themes/

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
