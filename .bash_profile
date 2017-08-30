# path-add & path-rm taken and updated from https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path
path-add() {
    newelement=${1%/}
    
    if [ -d "$1" ] && ! echo $PATH | grep -E -q "(^|:)$newelement($|:)" ; then
        if [ "$2" = "after" ] ; then
            PATH="$PATH:$newelement"
        else
            PATH="$newelement:$PATH"
        fi
    else
        echo "$newelement already in PATH!"
    fi
}

path-rm() {
    PATH="$(echo $PATH | sed -e "s;\(^\|:\)${1%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
}

path-rm-duplicates() {
    PATH=$(echo -n $PATH | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")
}

path-add "$HOME"
path-add "$HOME/bin"
path-rm-duplicates
export PATH

# Ensure that history is appended to its file, not overwritten 
shopt -s histappend
# Date format for displaying date & time in history
export HISTTIMEFORMAT='%F %T %t'

# Get the directory that this script, .bash_profile, is located in.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source the .bash_aliases file in the same directory as this file.
source $DIR/.bash_aliases

