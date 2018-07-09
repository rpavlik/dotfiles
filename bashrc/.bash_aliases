
export_prepend_unique() {
    varname=$1
    val=$2
    delim=:
    origval=${!varname}

    # echo "export_prepend_unique: var: $varname val: $val initial state: $origval"
    if [[ $origval ]]; then
        # Got something to iterate over.
        # Let's append a delim to the end, so we can always use the pattern to update.
        # (Otherwise, you end up stuck forever in a state where
        # $current equals $parsing equals the last element in the list,
        # and no delimiters left)
        # Loop inspired by https://www.tutorialkart.com/bash-shell-scripting/bash-split-string/
        # but not using an array ever, and had to make this minor workaround.
        parsing=$origval$delim
        while [[ $parsing ]]; do
            current="${parsing%%"$delim"*}"
            
            parsing="${parsing#*"$delim"}"
            # echo "Current: $current state: $parsing"
            if [ "$current" = "$val" ]; then
                # we found ourselves - can end loop here and bail!
                return
            fi
            #read dummy
        done
        # If we got here, we need to add our thing because it's not there yet.
        # And, we need to add a delim because there was a previous value.
        #eval export \$$varname=${val}${delim}\$$varname
        export $varname=${val}${delim}${origval}
    else
        # Empty original val, no delim needed
        export $varname=${val}
    fi
}

add_prefix() {
    #set -x
    DIRNAME=$1
    export_prepend_unique PATH "$DIRNAME/bin"
    export_prepend_unique MANPATH "$DIRNAME/share/man"
    export_prepend_unique INFOPATH "$DIRNAME/share/info"
    export_prepend_unique LD_LIBRARY_PATH "$DIRNAME/lib"
    #set +x
}

add_prefix $HOME/.local

# Only logs if the file already exists
LOG=~/rcfiles.txt
if [ -f $LOG ]; then
    # remote and recreate to empty the file
    rm -f $LOG
    touch $LOG
fi

for fn in $HOME/.bashrc.d/*.rc; do
    if [ -f $LOG ]; then
        echo $fn >> $LOG
    fi
    source $fn
done