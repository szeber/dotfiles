# ------------------------------------------------------------------------------
#          FILE:  figured.plugin.zsh
#   DESCRIPTION:  oh-my-zsh Figured plugin file.
#        AUTHOR:  Zsolt Szeberenyi (zsolt.szeberenyi@figured.com)
#       VERSION:  1.0.0
# ------------------------------------------------------------------------------

# Composer basic command completion
_figured_get_command_list () {
    $_comp_command1 help 2> /dev/null | grep -v "Valid commands" | awk '/^[ \t]*[a-z]+/ { print $1 }'
}

_composer_get_required_list () {
    $_comp_command1 show -s --no-ansi 2>/dev/null | sed '1,/requires/d' | awk 'NF > 0 && !/^requires \(dev\)/{ print $1 }'
}

_figured () {
  local curcontext="$curcontext" state line
  typeset -A opt_args
  _arguments \
    '1: :->command'\
    '*: :->args'

  case $state in
    command)
      compadd $(_figured_get_command_list)
      ;;
    *)
#        echo "NOT"
      _path_files
      ;;
  esac
}

compdef _figured figured

# Aliases
alias fig='./figured'
