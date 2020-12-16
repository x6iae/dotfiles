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
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update homebrew recipes
brew update

PACKAGES=(
    awscli
    awsebcli
    aws-elasticbeanstalk
    autoconf
    automake
    ffmpeg
    findutils
    git
    hub
    imagemagick
    jq
    libjpeg
    markdown
    memcached
    npm
    pkg-config
    postgresql
    pyenv
    python3
    the_silver_searcher
    vim
    wget
    zlib
    zsh
    zsh-completions
)

echo "##########----> Installing packages..."
brew install ${PACKAGES[@]}

echo "##########----> Cleaning up..."
brew cleanup

echo "##########----> Setting up cask..."
export HOMEBREW_CASK_OPTS="--appdir=/Applications"


## NOTE: virtualbox may fail as it'll require macos permissions under security & privacy
CASKS=(
    google-chrome
    libreoffice
    macdown
    postman
    skitch
    slack
    virtualbox
    whatsapp
)

echo "##########----> Installing cask apps..."
brew install --cask ${CASKS[@]}

echo "##########----> Installing fonts..."
brew tap homebrew/cask-cask-fonts
FONTS=(
    font-roboto
    font-clear-sans
)
brew install --cask ${FONTS[@]}

echo "##########----> Installing Python packages..."
pyenv install 3.7.3
pyenv global 3.7.3

PYTHON_PACKAGES=(
   ipython
   virtualenv
   virtualenvwrapper
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo "##########----> Installing Ruby gems..."
RUBY_GEMS=(
    bundler
)
sudo gem install ${RUBY_GEMS[@]}

echo "##########----> Installing global npm packages..."
npm install marked -g

echo "##########----> Installing OhMyZsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "##########----> Creating folder structure..."
[[ ! -d $HOME/workspace ]] && mkdir $HOME/workspace

echo "##########----> Bootstrapping complete"
