#!/bin/bash

# http://dxd8.com/archives/219/

TARGET_BASEDIR=$HOME/Dropbox/dotfiles/
LINK_BASEDIR=$HOME
FILES=(.zshrc .vimrc .gvimrc)
BACKUP=1

check_configuration()
{
    if [ ! $TARGET_BASEDIR ]; then
        echo "Error: TARGET_BASEDIR cannot be empty."
        return 1
    fi

    if [ ! $LINK_BASEDIR ]; then
        echo "Error: LINK_BASEDIR cannot be empty."
        return 1
    fi
 
    return 0
}

filter_configuration()
{
    local _FILE
    local -i _I=0

    TARGET_BASEDIR=${TARGET_BASEDIR%/}/
    LINK_BASEDIR=${LINK_BASEDIR%/}/

    for _FILE in ${FILES[@]}; do
        FILES[$_I]=${_FILE%/}
        _I=`expr $_I+1`
    done
}

is_link_duplicated()
{
    local _TARGET=`readlink $1`

    [ $_TARGET ] || return 1

    if [ $2 = $_TARGET ]; then
        return 0
    fi

    return 1
}

create_symlink()
{
    ! is_link_duplicated $2 $1 || return 0

    if [ $BACKUP -eq 0 ]; then
        ln -s -T $1 $2 >/dev/null 2>&1
    else
        ln -s -T --backup=numbered $1 $2 >/dev/null 2>&1
    fi

    if [ $? -eq 1 ]; then
        echo 'Error: Cannot create symbolic link.'
        return 1
    fi

    return 0
}

create_symlinks()
{
    local _TARGET_FILE
    local _LINK_FILE
    local _FILE

    for _FILE in ${FILES[@]}; do
        _TARGET_FILE=${TARGET_BASEDIR}${_FILE}
        _LINK_FILE=${LINK_BASEDIR}${_FILE}

        echo "$_LINK_FILE -> $_TARGET_FILE"

        create_symlink $_TARGET_FILE $_LINK_FILE || return 1
    done

    return 0
}

main()
{
    check_configuration || return 1
    filter_configuration || return 1
    echo 'Creating symbolic links ...'
    create_symlinks || return 1
    echo 'Done.'

    return 0
}

main || exit 1

exit 0
