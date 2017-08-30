PATH="/Users/fergusonsa:$PATH"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# Ensure that history is appended to its file, not overwritten 
shopt -s histappend
# Date format for displaying date & time in history
export HISTTIMEFORMAT='%F %T %t'

export ORCA_VERSION=1.0.1


source ~/.bashrc
