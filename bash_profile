# ~/.bash_profile: executed by bash(1) for login shells.

umask 002

# adds color to your prompt and directories under bash
# when you place under your home directory, rename this file to .bash_profile

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi
