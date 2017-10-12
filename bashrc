[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

# added by travis gem
[ -f /Users/sunday/.travis/travis.sh ] && source /Users/sunday/.travis/travis.sh

### Added by the Bluemix CLI
source /usr/local/Bluemix/bx/bash_autocomplete
