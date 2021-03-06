# UNIX Shell configuration.
#
# This is a mostly POSIX compatible shell RC file, with GNU Bash
# specific stuff executed only if the $SHELL is bash.

export SHRC_VERSION=bobby
export SHELL

if [ x$FROMLOGINPROFILE = xyes ]; then
    echo Login profile script is loading shell setup...
fi

###

### Default programs:

EDITOR=NONE
if [ "x$INSIDE_EMACS" = x ]; then
    # Find a sensible editor.
    for EDITOR in vi vim zile nano ex ed; do
        if which $EDITOR >/dev/null 2>&1; then
	    export EDITOR;
	    [ $EDITOR = vim ] && alias vi=vim
	    break
        fi
    done
    PAGER=less
elif [ "x$SSH_CONNECTION" != x ] && [ "x$TERM" = xdumb ]; then
    EDITOR=ed
    PAGER=tee
else
    EDITOR=emacsclient
    PAGER=$HOME/.emacs.d/extras/eless.sh
fi

if which $EDITOR 2>&1 >/dev/null; then
    true
else
    echo WARNING: no suitable editor found...
fi

export EDITOR
export PAGER

###

### Environment:

export GPG_TTY=$(tty)

###

### Shell settings:

#### Load shell-specific stuff:
case "$SHELL" in
    *bash) . $MYLIB/rc.bash ;;
    *) ;;
esac

###

#### Aliases & functions:
. $MYLIB/aliases.sh

# Rebuild known binary list.
hash -r


