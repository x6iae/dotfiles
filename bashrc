[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

### Added by the Bluemix CLI
source /usr/local/Bluemix/bx/bash_autocomplete
NPM_PACKAGES=$HOME/.npm-packages

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
