#!/usr/bin/env bash
#
# Bootstrap script for setting up a new OSX machine
#
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# - Twitter (app store)
# - Postgres.app (http://postgresapp.com/)
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/


## A BIG THANKS TO CODEINTHEHOLE FOR HIS GIST...
## I SHOULD MAKE THIS A SUBMODULE, BUT I WANT FULL CONTROL ON WHAT GOES IN AND WHAT STAYS IN. :)

echo "##########----> Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "##########----> Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew tap homebrew/dupes
brew install coreutils
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-which --with-default-names
brew install gnu-grep --with-default-names

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

PACKAGES=(
    ack
    awscli
    aws-elasticbeanstalk
    autoconf
    automake
    ffmpeg
    gettext
    git
    heroku
    hub
    imagemagick
    jq
    libjpeg
    markdown
    memcached
    node
    npm
    pkg-config
    postgresql
    pyenv
    rabbitmq
    readline
    rename
    terminal-notifier
    the_silver_searcher
    tmux
    tree
    vim
    wget
    xz
    zlib
    zsh
    zsh-completions
)

echo "##########----> Installing packages..."
brew install ${PACKAGES[@]}

echo "##########----> Cleaning up..."
brew cleanup

echo "##########----> Installing cask..."
brew install caskroom/cask/brew-cask

echo "##########----> Setting up cask..."
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

CASKS=(
    db-browser-for-sqlite
    deezer
    dropbox
    firefox
    google-chrome
    google-backup-and-sync
    gpgtools
    hackhands
    iterm2
    java
    macvim
    rubymine
    screenhero
    skype
    slack
    spotify
    spotify-notifications
    vagrant
    virtualbox
    vlc
    whatsapp
)

echo "##########----> Installing cask apps..."
brew cask install ${CASKS[@]}

echo "##########----> Installing fonts..."
brew tap caskroom/fonts
FONTS=(
    font-inconsolidata
    font-roboto
    font-clear-sans
)
brew cask install ${FONTS[@]}

echo "##########----> Installing Python packages..."
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo "##########----> Installing Ruby gems..."
RUBY_GEMS=(
    bundler
    filewatcher
    cocoapods
)
sudo gem install ${RUBY_GEMS[@]}

echo "##########----> Installing global npm packages..."
npm install marked -g

echo "##########----> Configuring OSX..."

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "##########----> Creating folder structure..."
[[ ! -d Wiki ]] && mkdir Wiki
[[ ! -d workspace ]] && mkdir workspace

echo "##########----> Bootstrapping complete"
