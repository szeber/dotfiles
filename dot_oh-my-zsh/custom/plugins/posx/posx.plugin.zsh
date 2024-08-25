# ------------------------------------------------------------------------------
#          FILE:  posx.plugin.zsh
#   DESCRIPTION:  oh-my-zsh posx plugin file.
#        AUTHOR:  Zsolt Szeberenyi (zsolt@szeberenyi.com)
#       VERSION:  1.0.0
# ------------------------------------------------------------------------------

# Composer basic command completion
_posx_get_command_list () {
    $_comp_command1 help 2> /dev/null | grep -v "Valid commands" | awk '/^[ \t]*[a-z]+/ { print $1 }'
}

_posx_get_command_argument() {
    cd "$(dirname $_comp_command1)"
    output=$($_comp_command1 autocomplete ${words[@]:1} 2> /dev/null)
    if [[ $output != "_null_" ]]; then
        echo $output
    fi
 }

_posx () {
  local curcontext="$curcontext" state line
  typeset -A opt_args
  _arguments \
    '1: :->command'\
    '*: :->commandarg'

  case $state in
    command)
      compadd $(_posx_get_command_list)
      ;;
    *)
      compadd $(_posx_get_command_argument)
      ;;
  esac
}

compdef _posx posx

# Aliases
alias posx='./posx'
