# custom fireplacetv oh-my-zsh theme
echo Loading fireplacetv oh-my-zsh theme...
### NVM

ZSH_THEME_NVM_PROMPT_PREFIX="%B⬡%b "
ZSH_THEME_NVM_PROMPT_SUFFIX=""

### Git [±master ▾●]

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}[%{$fg_bold[green]%}±%{$reset_color%}%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[magenta]%}✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}⚑%{$reset_color%}"

# Builds the git line from a single `git status` call, parsed in-shell (no
# subshells, no grep). Sets _GIT_PROMPT; empty when not in a repo.
bureau_git_prompt () {
  _GIT_PROMPT=""
  local _out
  _out=$(command git status --porcelain=v2 --branch --show-stash 2> /dev/null) || return

  local _line _branch _oid
  local -i _ahead=0 _behind=0 _stash=0 _staged=0 _unstaged=0 _untracked=0 _unmerged=0
  for _line in ${(f)_out}; do
    case $_line in
      ('# branch.oid '*)  _oid=${_line#\# branch.oid } ;;
      ('# branch.head '*) _branch=${_line#\# branch.head } ;;
      ('# branch.ab '*)
        local _ab=(${=_line#\# branch.ab })
        _ahead=${_ab[1]#+}; _behind=${_ab[2]#-} ;;
      ('# stash '*)       _stash=1 ;;
      ([12]' '*)
        [[ ${_line[3]} != . ]] && _staged=1
        [[ ${_line[4]} != . ]] && _unstaged=1 ;;
      ('u '*)             _unmerged=1 ;;
      ('? '*)             _untracked=1 ;;
    esac
  done

  [[ $_branch == '(detached)' ]] && _branch=${_oid[1,7]}

  local _status=""
  (( _staged ))    && _status+=$ZSH_THEME_GIT_PROMPT_STAGED
  (( _unstaged ))  && _status+=$ZSH_THEME_GIT_PROMPT_UNSTAGED
  (( _untracked )) && _status+=$ZSH_THEME_GIT_PROMPT_UNTRACKED
  (( _unmerged ))  && _status+=$ZSH_THEME_GIT_PROMPT_UNMERGED
  (( _staged + _unstaged + _untracked + _unmerged )) || _status+=$ZSH_THEME_GIT_PROMPT_CLEAN
  (( _ahead ))     && _status+=$ZSH_THEME_GIT_PROMPT_AHEAD
  (( _behind ))    && _status+=$ZSH_THEME_GIT_PROMPT_BEHIND
  (( _stash ))     && _status+=$ZSH_THEME_GIT_PROMPT_STASHED

  _GIT_PROMPT="$ZSH_THEME_GIT_PROMPT_PREFIX$_branch $_status$ZSH_THEME_GIT_PROMPT_SUFFIX"
}


_PATH="%{$fg_bold[white]%}%~%{$reset_color%}"
_TIMESTAMP="%{$FG[208]%}(%D{%b %d %H:%M:%S})%{$reset_color%}"

if [[ $EUID -eq 0 ]]; then
  _USERNAME="%{$fg_bold[red]%}%n"
  _LIBERTY="%{$fg[red]%}#"
else
  _USERNAME="%{$FG[208]%}%n"
  _LIBERTY="%{$FG[214]%}$"
fi
_USERNAME="$_USERNAME%{$FG[214]%}@%m%{$reset_color%}"
_LIBERTY="$_LIBERTY%{$reset_color%}"


get_space () {
  local STR=$1$2
  local zero='%([BSUbfksu]|([FB]|){*})'
  local LENGTH=${#${(S%%)STR//$~zero/}}
  local SPACES=""
  (( LENGTH = ${COLUMNS} - $LENGTH - 1))

  for i in {0..$LENGTH}
    do
      SPACES="$SPACES "
    done

  echo $SPACES
}

_1LEFT="$_TIMESTAMP $_PATH" 
_1RIGHT="[%*]"

bureau_precmd () {
  print
  # _1SPACES=`get_space $_1LEFT $_1RIGHT`
  # print -rP "$_1LEFT$_1SPACES$_1RIGHT"
  print -rP "$_1LEFT"
  bureau_git_prompt
  if [[ -n $_GIT_PROMPT ]]; then
      print -rP "${_GIT_PROMPT}"
  fi
}

setopt prompt_subst
PROMPT='$_LIBERTY '

# right side prompt from original theme. this is distracting.
# RPROMPT='$(nvm_prompt_info) $_GIT_PROMPT'

autoload -U add-zsh-hook
add-zsh-hook precmd bureau_precmd

