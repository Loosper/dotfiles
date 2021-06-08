My attempt to document my dotfiles

After setting up dotfiles:
1. Install oh-my-zsh `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
1. move junkfood theme to .ohmyzsh dirA
1. Install zsh plugins: 
* zsh-autosuggestions `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
* zsh-syntax-highlighting `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
* alias-tips `git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips`
1. Install badwolf vim colour scheme
1. Install gti and sl
1. Add `Defaults insults` with visudo
Defaults timestamp_timeout=30
1. Install gef to get the actual .gdbinit

disable xdg dirs

* to make Nautilus show with lists by defualt
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
* to make Nautilus always show full path (ctrl+l also works)
gsettings set org.gnome.nautilus.preferences always-use-location-entry true


* VLC vlsub unable to save subtitles:
mkdrir ~/.cache/vlc


READ the TODO file
