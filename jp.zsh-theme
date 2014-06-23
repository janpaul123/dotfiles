# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function git_time_since_commit() {
  if last_commit=`git show -s --format='%at' 2> /dev/null`; then
      # Get the last commit.

      now=`date +%s`
      seconds_since_last_commit=$((now-last_commit))

      # Totals
      MINUTES=$((seconds_since_last_commit / 60))
      HOURS=$((seconds_since_last_commit/3600))

      # Sub-hours and sub-minutes
      DAYS=$((seconds_since_last_commit / 86400))
      SUB_HOURS=$((HOURS % 24))
      SUB_MINUTES=$((MINUTES % 60))

      if [ "$MINUTES" -gt 30 ]; then
          COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
      elif [ "$MINUTES" -gt 10 ]; then
          COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
      else
          COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
      fi

      if [ "$HOURS" -gt 24 ]; then
          echo " $COLOR${DAYS}d"
      elif [ "$MINUTES" -gt 60 ]; then
          echo " $COLOR${HOURS}h${SUB_MINUTES}m"
      else
          echo " $COLOR${MINUTES}m"
      fi
  fi
}

function battery_pct() {
  typeset -F maxcapacity=$(ioreg -rc "AppleSmartBattery"| grep '^.*"MaxCapacity"\ =\ ' | sed -e 's/^.*"MaxCapacity"\ =\ //')
  typeset -F currentcapacity=$(ioreg -rc "AppleSmartBattery"| grep '^.*"CurrentCapacity"\ =\ ' | sed -e 's/^.*CurrentCapacity"\ =\ //')
  integer i=$(((currentcapacity/maxcapacity) * 100))
  echo $i
}

function battery_pct_remaining() {
  if [[ $(ioreg -rc AppleSmartBattery | grep -c '^.*"ExternalConnected"\ =\ No') -eq 1 ]] ; then
    battery_pct
  else
    echo "∞"
  fi
}

function battery_pct_prompt () {
  if [[ $(ioreg -rc AppleSmartBattery | grep -c '^.*"ExternalConnected"\ =\ No') -eq 1 ]] ; then
    b=$(battery_pct_remaining)
    if [ $b -gt 50 ] ; then
      color='green'
    elif [ $b -gt 20 ] ; then
      color='yellow'
    else
      color='red'
    fi
    echo " %{$fg[$color]%}$(battery_pct_remaining)%%%{$reset_color%}"
  else
    echo ""
  fi
}

function git_prompt_info_custom() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  # echo "$(parse_git_dirty)${ref#refs/heads/}$(git_prompt_ahead)%{$reset_color%}"
  echo "$(parse_git_dirty)${ref#refs/heads/}%{$reset_color%}"
}

PROMPT='%{$fg[magenta]%}%c %{$fg[green]%}%(?..%{$fg[red]%})ЯΠ%{$reset_color%}  '
RPROMPT='$(git_prompt_info_custom)$(git_time_since_commit)%{$reset_color%}$(battery_pct_prompt)'
# RPROMPT='$(git_prompt_info_custom)%{$reset_color%}$(battery_pct_prompt)'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}+"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"

# git_remote_status doesn't seem to work properly
# ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg[yellow]%}↓"
# ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg[green]%}↑"
# ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg[red]%}⑂"

# Too slow.. :-(
# ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[yellow]%}↑"
