# pathadd & pathrm taken and updated from https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path
pathadd() {
    newelement=${1%/}
    
    if [ -d "$1" ]; then
    
        if ! echo $PATH | grep -E -q "(^|:)$newelement($|:)" ; then
            if [ "$2" = "after" ] ; then
                PATH="$PATH:$newelement"
            else
                PATH="$newelement:$PATH"
            fi
        else
            echo "$newelement already in PATH!"
        fi
    else
        echo "$newelement is not a valid directory!"
    fi
}

pathrm() {
    PATH="$(echo $PATH | sed -e "s;\(^\|:\)${1%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
}

pathrmduplicates() {
    PATH=$(echo -n $PATH | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")
}

pathadd "$HOME"
pathadd "$HOME/bin"
pathrmduplicates
export PATH

export TTY_NAME=`temp=$(tty) ; echo ${temp:5}`

# Ensure that the ~/reports/bash_history directory exists
mkdir -p "${HOME}/reports/bash_history"

# Function for saving history to separate log file every 15 minutes
logBashHistory() {
#   history 1 | sed -e "s/^./$TTY_NAME &/" >> ~/reports/bash_history/bash_history-$(date +"%Y-%m-%d").txt
  echo $TTY_NAME \"`pwd`\" `history 1` >> ~/reports/bash_history/bash_history-$(date +"%Y-%m-%d").txt
}

# Ensure that history is appended to its file, not overwritten 
shopt -s histappend
# Date format for displaying date & time in history
export HISTTIMEFORMAT='%F %T %t'

# Set the prompt to be 
PS1="\u@\h:\w \$ "

# Get the directory that this script, .bash_profile, is located in.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source the .bash_aliases file in the same directory as this file.
source $DIR/.bash_aliases


if ! echo $PROMPT_COMMAND | grep -E -q "(;)logBashHistory(;)" ; then
    export PROMPT_COMMAND="logBashHistory; $PROMPT_COMMAND"
fi
