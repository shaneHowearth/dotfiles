# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
if [ -d "$HOME/.local/vim/bin/" ] ; then
  PATH="$HOME/.local/vim/bin/:$PATH"
fi


export GOPATH=$HOME/go
export SRC=$GOPATH/src
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH=$GOPATH/src/fabric-samples/bin:$PATH
export BB_TOKEN=MzgyMzAzMTI3MDg1OgrqzPsBGOI4rjUnXCNnKr6oJY5P
alias dr=docker
alias delve=dlv
alias vi=vim
alias gr='grep --color=always -riIn'
drrm() {
    docker stop $(docker ps -q)
    docker rm $(docker ps -aq)
}

function cdr () {
    docker exec -it "$1" bash
}

# The various escape codes that we can use to color our prompt.
          RED="\[\e[0;31m\]"
        GREEN="\[\e[0;32m\]"
       YELLOW="\[\e[0;33m\]"
         BLUE="\[\e[0;34m\]"
      MAGENTA="\[\e[0;35m\]"
         CYAN="\[\e[0;36m\]"
         GRAY="\[\e[0;37m\]"
    LIGHT_RED="\[\e[1;31m\]"
  LIGHT_GREEN="\[\e[1;32m\]"
 LIGHT_YELLOW="\[\e[1;33m\]"
   LIGHT_BLUE="\[\e[1;34m\]"
LIGHT_MAGENTA="\[\e[1;35m\]"
   LIGHT_CYAN="\[\e[1;36m\]"
        WHITE="\[\e[1;37m\]"
WHITE_ON_GREEN="\[\e[42;1;37m\]"
WHITE_ON_YELLOW="\[\e[43;1;37m\]"
WHITE_ON_MAGENTA="\[\e[45;1;37m\]"
WHITE_ON_RED="\[\e[41;1;37m\]"
   COLOR_NONE="\[\e[0m\]"

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  local git_status="$(git status -unormal 2>&1)"

  if [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
      BRANCH=''
      return
  fi

  if [[ ${git_status} =~ "working directory clean" ]]; then
    state="${WHITE_ON_GREEN}"
  elif [[ ${git_status} =~ "nothing added to commit but untracked
files present" ]]; then
    state="${WHITE_ON_YELLOW}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${WHITE_ON_MAGENTA}"
  else
    state="${WHITE_ON_RED}"
  fi

  # Set arrow icon based on status against remote.
  remote_pattern="# Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  else
    remote=""
  fi
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi

  # Get the name of the branch.
  branch_pattern="^# On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  fi

  # If branch is master, just use a space.
  if [[ ${branch} = "master" ]]; then
    branch=' '
  else
    branch=(${branch})
  fi

  # Set the final branch string.
  BRANCH="${state}${branch}${remote}${COLOR_NONE} "
}

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="\$"
  else
      PROMPT_SYMBOL="${WHITE_ON_RED}!${COLOR_NONE}"
  fi
}


# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?

  # Set the BRANCH variable.
  set_git_branch

  # Set the bash prompt variable.
  PS1="${COLOR_NONE}\u@\h \w ${BRANCH} ${PROMPT_SYMBOL} "
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
if [[ $DISPLAY ]]; then
  [[ $- != *i* ]] && return
  [[ -z "$TMUX" ]] && export TERM=xterm-256color && exec tmux
fi
